# $Id$

PKGNAME=	mupdf-chroot-1.0.0
CATEGORIES=	print

OWNER=		alnsn@yandex.ru
HOMEPAGE=	https://github.com/alnsn/localpkgsrc
COMMENT=	chroot wrapper for mupdf
LICENSE=	public-domain

# Fake build dependencies to force building of these packages.
BUILD_DEPENDS+=	mupdf>=1.9a:../../print/mupdf
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
SUBST_FILES.vars=	mupdf-chroot mupdf-chroot-libexec
SUBST_VARS.vars=	PREFIX

do-extract:
	cp ${FILESDIR}/mupdf-chroot* ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/mupdf-chroot ${DESTDIR}/${PREFIX}/bin/mupdf-chroot
	${INSTALL_SCRIPT} ${WRKSRC}/mupdf-chroot-libexec ${DESTDIR}/${PREFIX}/libexec/mupdf-chroot

.include "../../mk/bsd.pkg.mk"
