# audit_print
#
# RFC 1179 describes the Berkeley system based line printer protocol.
# The service is used to control local Berkeley system based print spooling.
# It listens on port 515 for incoming print jobs.
# Secure by default limits access to the line printers by only allowing
# print jobs to be initiated from the local system.
# If the machine does not have locally attached printers,
# disable this service.
# Note that this service is not required for printing to a network printer.
#
# Refer to Section 3.14 Page(s) 14-15 CIS FreeBSD Benchmark v1.0.5
#.

audit_print () {
  if [ "$os_name" = "SunOS" ] || [ "$os_name" = "FreeBSD" ]; then
    funct_verbose_message "Printing Daemons"
    if [ "$os_name" = "SunOS" ]; then
      if [ "$os_version" = "10" ]; then
        service_name="svc:/application/print/ipp-listener:default"
        funct_service $service_name disabled
        service_name="svc:/application/print/rfc1179"
        funct_service $service_name disabled
        service_name="svc:/application/print/server:default"
        funct_service $service_name disabled
      fi
    fi
    if [ "$os_name" = "FreeBSD" ]; then
      check_file="/etc/rc.conf"
      funct_file_value $check_file lpd_enable eq NO hash
    fi
  fi
}