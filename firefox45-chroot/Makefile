# $Id$

PKGNAME=	firefox45-chroot-1.0.0
CATEGORIES=	www

OWNER=		alnsn@yandex.ru
HOMEPAGE=	https://github.com/alnsn/localpkgsrc
COMMENT=	chroot wrapper for www/firefox45
LICENSE=	public-domain

# Fake build dependencies to force building of these packages.
BUILD_DEPENDS+=	firefox45>=45.0:../../www/firefox45
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
SUBST_FILES.vars=	firefox45-chroot firefox45-chroot-libexec
SUBST_VARS.vars=	PREFIX

do-extract:
	cp ${FILESDIR}/firefox45-chroot* ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/firefox45-chroot ${DESTDIR}/${PREFIX}/bin/firefox45-chroot
	${INSTALL_SCRIPT} ${WRKSRC}/firefox45-chroot-libexec ${DESTDIR}/${PREFIX}/libexec/firefox45-chroot

.include "../../mk/bsd.pkg.mk"
