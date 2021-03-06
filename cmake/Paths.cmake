# Now CMAKE_INSTALL_PREFIX is a base prefix for everything
# CONFDIR - for configuration
# LOCAL_CONFDIR - for local configuration
# MANDIR - for manual pages
# RUNDIR - for runtime files
# DBDIR - for static files
# LOGDIR - for log files
# EXAMPLESDIR - for examples files

IF(NOT CONFDIR)
    SET(CONFDIR "${CMAKE_INSTALL_PREFIX}/etc/rspamd")
ENDIF(NOT CONFDIR)

IF(NOT LOCAL_CONFDIR)
    SET(LOCAL_CONFDIR "${CONFDIR}")
ENDIF(NOT LOCAL_CONFDIR)

IF(NOT MANDIR)
    SET(MANDIR "${CMAKE_INSTALL_PREFIX}/share/man")
ENDIF(NOT MANDIR)

IF(NOT RUNDIR)
    SET(RUNDIR "/var/run/rspamd")
ENDIF(NOT RUNDIR)

IF(NOT DBDIR)
    SET(DBDIR "/var/lib/rspamd")
ENDIF(NOT DBDIR)

IF(NOT LOGDIR)
    SET(LOGDIR "/var/log/rspamd")
ENDIF(NOT LOGDIR)

IF(NOT SHAREDIR)
    SET(SHAREDIR "${CMAKE_INSTALL_PREFIX}/share/rspamd")
ENDIF(NOT SHAREDIR)

IF(NOT EXAMPLESDIR)
    SET(EXAMPLESDIR "${CMAKE_INSTALL_PREFIX}/share/examples/rspamd")
ENDIF(NOT EXAMPLESDIR)

IF(NOT LUALIBDIR)
    SET(LUALIBDIR "${SHAREDIR}/lualib")
ENDIF(NOT LUALIBDIR)

IF(NOT PLUGINSDIR)
    SET(PLUGINSDIR "${SHAREDIR}/plugins")
ENDIF(NOT PLUGINSDIR)

IF(NOT RULESDIR)
    SET(RULESDIR "${SHAREDIR}/rules")
ENDIF(NOT RULESDIR)

IF(NOT WWWDIR)
    SET(WWWDIR "${SHAREDIR}/www")
ENDIF(NOT WWWDIR)

# Set libdir
IF(NOT LIBDIR)
    SET(RSPAMD_LIBDIR "${CMAKE_INSTALL_PREFIX}/lib/rspamd")
ELSE(NOT LIBDIR)
    SET(RSPAMD_LIBDIR "${LIBDIR}")
ENDIF(NOT LIBDIR)
SET(CMAKE_MACOSX_RPATH ON)
SET(CMAKE_INSTALL_RPATH "${RSPAMD_LIBDIR}")

# Set includedir
IF(NOT INCLUDEDIR)
    SET(INCLUDEDIR include/rspamd)
ENDIF(NOT INCLUDEDIR)

IF(NOT SYSTEMDDIR)
    SET(SYSTEMDDIR ${CMAKE_INSTALL_PREFIX}/lib/systemd/system)
ENDIF(NOT SYSTEMDDIR)

SET(RSPAMD_DEFAULT_INCLUDE_PATHS "/opt;/usr;/usr/local;/opt/local;/usr/pkg;/opt/csw;/sw")
SET(RSPAMD_DEFAULT_LIBRARY_PATHS "/usr/local;/usr/pkg;/usr;/Library/Frameworks;/sw;/opt/local;/opt/csw;/opt")
