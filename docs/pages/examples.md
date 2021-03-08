# Examples

## CLI

Search default credentials for a specific vendor / product

```plaintext
$ pass-station search Weblogic
+----------------+----------+------------+
| productvendor  | username | password   |
+----------------+----------+------------+
| weblogic       | system   | weblogic   |
| Weblogic (web) | EXAMPLES | EXAMPLES   |
| Weblogic (web) | monitor  | password   |
| Weblogic (web) | operator | password   |
| Weblogic (web) | operator | weblogic   |
| Weblogic (web) | PUBLIC   | PUBLIC     |
| Weblogic (web) | system   | manager    |
| Weblogic (web) | system   | Passw0rd   |
| Weblogic (web) | system   | password   |
| Weblogic (web) | system   | welcome(1) |
| Weblogic (web) | weblogic | weblogic   |
| Weblogic (web) | WEBLOGIC | WEBLOGIC   |
| Weblogic (web) | weblogic | weblogic1  |
| Weblogic (web) | weblogic | welcome(1) |
+----------------+----------+------------+
```

Search default credentials with a specific username respecting the case

```plaintext
$ pass-station search WEBLOGIC --field username --sensitive
+----------------+----------+----------+
| productvendor  | username | password |
+----------------+----------+----------+
| Weblogic (web) | WEBLOGIC | WEBLOGIC |
+----------------+----------+----------+
```

Search default credentials with a regexp in all fields (product/vendor, username, password)

```plaintext
$ pass-station search 'admin[0-9]+' --field all
+----------------------------------+----------+------------+
| productvendor                    | username | password   |
+----------------------------------+----------+------------+
| AdComplete.com                   | Admin1   | Admin1     |
| Avaya                            | admin    | admin123   |
| Avaya                            | dadmin   | dadmin01   |
| Exacq Technologies               | admin    | admin256   |
| Groupee,Inc.                     | Admin5   | 4tugboat   |
| IBM Storwize V7000 Unified (ssh) | admin    | admin0001  |
| Kyocera                          | <blank>  | admin00    |
| McAfee                           | admin    | admin123   |
| NAI                              | admin    | admin123   |
| NetApp                           | admin    | admin123   |
| Nexus Repository Manager (web)   | admin    | admin123   |
| Nortel                           | admin    | admin000   |
| RM                               | admin2   | changeme   |
| RSA                              | admin    | admin1234  |
| Schlage SMS (mssql)              | sa       | SECAdmin1  |
| Schlage SMS (mssql)              | SMSAdmin | SECAdmin1  |
| ShoreTel                         | Admin    | admin1     |
| SKF @ptitude Analyst (mssql)     | sa       | skf_admin1 |
| telnet (telnet)                  | admin1   | password   |
| telnet (telnet)                  | admin    | admin1234  |
+----------------------------------+----------+------------+
```

List all entries sorted by username displayed as a simple table

```plaintext
$ pass-station list --sort username --output table
productvendor                                        username                   password
Livingston                                           !root                      <blank>
IBM                                                  $ALOC$                     <blank>
IBM                                                  $SRV                       $SRV
Nurit                                                $system                    <blank>
Lucent                                               (any 3 characters)         cascade
Lucent                                               (any 3 chars)              cascade
APC                                                  (any)                      TENmanUFactOryPOWER
Telus                                                (created)                  telus00
Telus                                                (created)                  telus99
Elron                                                (hostname/ipaddress)       sysadmin
Norstar                                              **23646                    23646
Norstar                                              **266344                   266344
Digital Equipment                                    1                          manager
Digital Equipment                                    1                          operator
Digital Equipment                                    1                          syslib
Digital Equipment                                    1.1                        SYSTEM
Xerox                                                11111                      x-admin
Xerox WorkCentre 5020/DN (printer)                   11111                      <blank>
IBM                                                  11111111                   11111111
...
```
