How to chroot www/firefox on NetBSD
===================================

This quick guide explains how to install `www/firefox` on NetBSD into
chroot directory `/home/webuser-chroot` and run it under `webuser` user.

The guide assumes that `www/firefox` is built with the following options:

	PKG_OPTIONS.firefox=		-dbus -alsa -pulseaudio oss

Your `X(7)` must be reconfigured to listen tcp:

	# .xserverrc
	X -listen tcp

Don't forget to disable non-local hosts with `xhost` or by adding
entries to `/etc/X0.hosts`.

Export variables
----------------

	export TMPDIR=/tmp
	export CHROOT=/home/webuser-chroot
	export PACKAGES=/path/to/pkgsrc/packages

Create barebone NetBSD base
---------------------------

Run these commands as `root`:

	umask 022
	
	for d in dev etc/openssl/certs tmp usr/pkg/etc/fontconfig var/db/pkg var/shm var/tmp webuser
	do
		mkdir -p "${CHROOT:?}/$d"
	done
	
	chown webuser:webuser "${CHROOT:?}/webuser"

Temporary directories and `/var/shm` should be accessible to everyone
and they should have sticky flags set:

	chmod a+rwxt "${CHROOT:?}/tmp" "${CHROOT:?}/var/tmp" "${CHROOT:?}/var/shm"

The above command also creates `/var/shm` for the new shared memory API but
the current version (46.0.1) of `www/firefox` still uses the old API. It case
it changes in a future, you should add a new mountpoint to `/etc/fstab`:

	tmpfs		/home/webuser-chroot/var/shm	tmpfs	rw,noexec,nocoredump,-m1777,-sram%5

The next command is very important because your firefox process
must have access to random bits. For some reason, firefox doesn't
complain if these special files aren't accessible.

	pax -rw /dev/random /dev/urandom /dev/null /dev/sound* /dev/mixer* "${CHROOT:?}"
	
	chmod a+w "${CHROOT:?}/dev/null"

Next, create empty files in `/etc`:

	touch "${CHROOT:?}/etc/passwd" "${CHROOT:?}/etc/fstab" "${CHROOT:?}/etc/mime.types"

You also need `/etc/resolv.conf`. If you run dns (for instance, `net/dnsmasq`)
on your local machine, you can add localhost:

	echo nameserver 127.0.0.1 > "${CHROOT:?}/etc/resolv.conf"

Install www/firefox and fonts/dejavu-ttf
----------------------------------------

Some of `www/firefox` dependencies are shared libaries from the
base NetBSD system. They can be listed with a special command
but it only works for installed packages. We install `www/firefox`
and `fonts/dejavu-ttf` first and then go back to installing
the barebone base system.

	pkg_add -P "${CHROOT:?}" -K var/db/pkg "${PACKAGES:?}/firefox" "${PACKAGES:?}/dejavu-ttf"

Create barebone NetBSD base, part 2
-----------------------------------

Now list all dependencies with `pkg_info -Q REQUIRES` and install
them with `pax -rw`:

	pkg_info -K "${CHROOT:?}/var/db/pkg" -Q REQUIRES firefox dejavu-ttf gdk-pixbuf2 | grep -v /usr/pkg/ | pax -rw "${CHROOT:?}"
	
	pkg_info -K "${CHROOT:?}/var/db/pkg" -Q REQUIRES firefox dejavu-ttf gdk-pixbuf2 | grep -v /usr/pkg/ | xargs readlink -f | pax -rw "${CHROOT:?}"

The `gdk-pixbuf2` is listed among packages because it will be needed 
later to create a required config file.

Install the runtime linker:

	pax -rw /libexec/ld.elf_so /usr/libexec/ld.elf_so "${CHROOT:?}"

Install `i18n` libraries and other `i18n` files:

	pax -rw /usr/lib/i18n /usr/share/i18n "${CHROOT:?}"

Configure
---------

Install root certificates:

	mozilla-rootcerts -d "${CHROOT:?}" install

Configure fonts:

	cp "${CHROOT:?}/usr/pkg/share/examples/fontconfig/fonts.conf" "${CHROOT:?}/usr/pkg/etc/fontconfig/fonts.conf"

	chroot "${CHROOT:?}" /usr/pkg/bin/fc-cache -f

Firefox complains about missing
`/usr/pkg/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache` (version number
may be different). This file can be generated:

	chroot "${CHROOT:?}" /usr/pkg/bin/gdk-pixbuf-query-loaders > "${TMPDIR:?}/loaders.cache"
	
	mv "${TMPDIR:?}/loaders.cache" "${CHROOT:?}/usr/pkg/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"

Cleanup
-------

Packages in `pkgsrc` are rarely split into subpackages like `libxxx`,
`xxx-dev`, `xxx-doc` etc. This introduces some unnecessary dependencies
like `lang/python` or `lang/perl`. They can be removed with `pkg_delete -f`:

	pkg_delete -P "${CHROOT:?}" -K var/db/pkg -f perl python27 mozilla-rootcerts

Next, find suid and guid binaries:

	find "${CHROOT:?}" -perm -4000 -o -perm -2000

and identify packages for deletion with `pkg_info -F` (there are none for
the current version of `www/firefox`):

	pkg_info -K "${CHROOT:?}/var/db/pkg" -F /usr/pkg/bin/firefox

Start firefox
-------------

	/usr/bin/env -i USER=webuser HOME=/webuser DISPLAY=127.0.0.1:0.0 \
		/usr/sbin/chroot -u webuser /home/webuser-chroot /usr/pkg/bin/firefox 

or install `local/firefox-chroot` from this repository and run `firefox-chroot`.

Misc
----

To generate a dependency graph of installed packages, run the following command
as a regular user:

	pkgdepgraph -d "${CHROOT:?}/var/db/pkg" | dot -Tsvg -o "${CHROOT:?}/tmp/pkgdepgraph.svg"
