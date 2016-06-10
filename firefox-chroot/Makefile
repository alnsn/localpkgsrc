# $Id$

PKGNAME=	firefox-chroot-1.0.0
CATEGORIES=	www

OWNER=		alnsn@yandex.ru
HOMEPAGE=	https://github.com/alnsn/localpkgsrc
COMMENT=	chroot wrapper for firefox
LICENSE=	public-domain

# Fake build dependencies to force building of these packages.
BUILD_DEPENDS+=	firefox-46.0:../../www/firefox
BUILD_DEPENDS+=	dejavu-ttf-2.35:../../fonts/dejavu-ttf

DEPENDS+=	sudo:../../security/sudo
DEPENDS+=	ssh-askpass:../../security/ssh-askpass

PKG_INSTALLATION_TYPES=	overwrite pkgviews

WRKSRC=		${WRKDIR}
USE_LANGUAGES=	# empty
NO_BUILD=	yes

INSTALLATION_DIRS=	bin libexec

.include "../../mk/bsd.prefs.mk"

SUBST_CLASSES+=		vars
SUBST_STAGE.vars=	pre-configure
SUBST_MESSAGE.vars=	Configuring sources.
SUBST_FILES.vars=	firefox-chroot firefox-chroot-libexec
SUBST_VARS.vars=	PREFIX

do-extract:
	cp ${FILESDIR}/firefox-chroot*  ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/firefox-chroot ${DESTDIR}/${PREFIX}/bin/firefox-chroot
	${INSTALL_SCRIPT} ${WRKSRC}/firefox-chroot-libexec ${DESTDIR}/${PREFIX}/libexec/firefox-chroot

.include "../../mk/bsd.pkg.mk"
