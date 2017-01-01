# $Id$

PKGNAME=	links-gui-chroot-1.0.0
CATEGORIES=	www

OWNER=		alnsn@yandex.ru
HOMEPAGE=	https://github.com/alnsn/localpkgsrc
COMMENT=	chroot wrapper for www/links-gui
LICENSE=	public-domain

# Fake build dependencies to force building of these packages.
BUILD_DEPENDS+=	links-gui>=2.14:../../www/links-gui
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
SUBST_FILES.vars=	links-gui-chroot links-gui-chroot-libexec
SUBST_VARS.vars=	PREFIX

do-extract:
	cp ${FILESDIR}/links-gui-chroot* ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/links-gui-chroot ${DESTDIR}/${PREFIX}/bin/links-gui-chroot
	${INSTALL_SCRIPT} ${WRKSRC}/links-gui-chroot-libexec ${DESTDIR}/${PREFIX}/libexec/links-gui-chroot

.include "../../mk/bsd.pkg.mk"
