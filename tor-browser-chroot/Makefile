# $Id$

PKGNAME=	tor-browser-chroot-1.0.0
CATEGORIES=	security www

OWNER=		alnsn@yandex.ru
HOMEPAGE=	https://github.com/alnsn/localpkgsrc
COMMENT=	chroot wrapper for tor-browser
LICENSE=	public-domain

# Fake build dependencies to force building of these packages.
BUILD_DEPENDS+=	tor-browser>=6.0.8:../../security/tor-browser
BUILD_DEPENDS+=	dejavu-ttf>=2.35:../../fonts/dejavu-ttf

DEPENDS+=	sudo>=1.8.15:../../security/sudo
DEPENDS+=	ssh-askpass>=1.0:../../security/ssh-askpass

PKG_INSTALLATION_TYPES=	overwrite pkgviews

WRKSRC=		${WRKDIR}
USE_LANGUAGES=	# empty
NO_BUILD=	yes

INSTALLATION_DIRS=	bin libexec

.include "../../mk/bsd.prefs.mk"

SUBST_CLASSES+=		vars
SUBST_STAGE.vars=	pre-configure
SUBST_MESSAGE.vars=	Configuring sources.
SUBST_FILES.vars=	tor-browser-chroot tor-browser-chroot-libexec
SUBST_VARS.vars=	PREFIX

do-extract:
	cp ${FILESDIR}/tor-browser-chroot* ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/tor-browser-chroot ${DESTDIR}/${PREFIX}/bin/tor-browser-chroot
	${INSTALL_SCRIPT} ${WRKSRC}/tor-browser-chroot-libexec ${DESTDIR}/${PREFIX}/libexec/tor-browser-chroot

.include "../../mk/bsd.pkg.mk"
