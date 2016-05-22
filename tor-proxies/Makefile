# $Id$

PKGNAME=	tor-proxies-1.0.0
CATEGORIES=	net security

OWNER=		alnsn@andex.ru
HOMEPAGE=	http://localhost
COMMENT=	msmtp and ssh proxies
LICENSE=	public-domain

DEPENDS+=	tor>=0.2.3:../../net/tor
DEPENDS+=	socat>=1.4.32:../../net/socat

PKG_INSTALLATION_TYPES=	overwrite pkgviews

WRKSRC=		${WRKDIR}
USE_LANGUAGES=	# empty
NO_BUILD=	yes

INSTALLATION_DIRS=	libexec

.include "../../mk/bsd.prefs.mk"

SUBST_CLASSES+=		vars
SUBST_STAGE.vars=	pre-configure
SUBST_MESSAGE.vars=	Configuring sources.
SUBST_FILES.vars=	tor-msmtp-proxy tor-ssh-proxy
SUBST_VARS.vars=	PREFIX

REPLACE_SH+=		tor-msmtp-proxy tor-ssh-proxy

do-extract:
	cp ${FILESDIR}/tor-msmtp-proxy ${WRKSRC}
	cp ${FILESDIR}/tor-ssh-proxy*  ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/tor-msmtp-proxy ${DESTDIR}/${PREFIX}/libexec
	${INSTALL_SCRIPT} ${WRKSRC}/tor-ssh-proxy*  ${DESTDIR}/${PREFIX}/libexec

.include "../../mk/bsd.pkg.mk"
