/*
------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                  S Y S T E M . O S _ C O N S T A N T S                   --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 2000-2019, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

pragma Style_Checks ("M32766");
--  Allow long lines

*/
/*
--  This package provides target dependent definitions of constant for use
--  by the GNAT runtime library. This package should not be directly with'd
--  by an application program.

--  This file is generated automatically, do not modify it by hand! Instead,
--  make changes to s-oscons-tmplt.c and rebuild the GNAT runtime library.
*/



/*
package System.OS_Constants is

   pragma Pure;
*/
/*

   ---------------------------------
   -- General platform parameters --
   ---------------------------------

   type OS_Type is (Windows, Other_OS);
*/
#define Target_OS                     Other_OS
/*
   pragma Warnings (Off, Target_OS);
   --  Suppress warnings on Target_OS since it is in general tested for
   --  equality with a constant value to implement conditional compilation,
   --  which normally generates a constant condition warning.

*/
#define Target_Name                   "x86_64-apple-darwin17.7.0"
#define SIZEOF_unsigned_int           4
#define Serial_Port_Descriptor Interfaces.C.int
/*

   -------------------
   -- System limits --
   -------------------

*/
#define IOV_MAX                       1024
#define NAME_MAX                      255
/*

   ---------------------
   -- File open modes --
   ---------------------

*/
#define O_RDWR                        2
#define O_NOCTTY                      131072
#define O_NDELAY                      4
/*

   ----------------------
   -- Fcntl operations --
   ----------------------

*/
#define F_GETFL                       3
#define F_SETFL                       4
/*

   -----------------
   -- Fcntl flags --
   -----------------

*/
#define FNDELAY                       4
/*

   ----------------------
   -- Ioctl operations --
   ----------------------

*/
#define IOCTL_Req_T Interfaces.C.int
#define FIONBIO                       -2147195266
#define FIONREAD                      1074030207
/*

   ------------------
   -- Errno values --
   ------------------

   --  The following constants are defined from <errno.h>

*/
#define EAGAIN                        35
#define ENOENT                        2
#define ENOMEM                        12
#define EACCES                        13
#define EADDRINUSE                    48
#define EADDRNOTAVAIL                 49
#define EAFNOSUPPORT                  47
#define EALREADY                      37
#define EBADF                         9
#define ECONNABORTED                  53
#define ECONNREFUSED                  61
#define ECONNRESET                    54
#define EDESTADDRREQ                  39
#define EFAULT                        14
#define EHOSTDOWN                     64
#define EHOSTUNREACH                  65
#define EINPROGRESS                   36
#define EINTR                         4
#define EINVAL                        22
#define EIO                           5
#define EISCONN                       56
#define ELOOP                         62
#define EMFILE                        24
#define EMSGSIZE                      40
#define ENAMETOOLONG                  63
#define ENETDOWN                      50
#define ENETRESET                     52
#define ENETUNREACH                   51
#define ENOBUFS                       55
#define ENOPROTOOPT                   42
#define ENOTCONN                      57
#define ENOTSOCK                      38
#define EOPNOTSUPP                    102
#define EPIPE                         32
#define EPFNOSUPPORT                  46
#define EPROTONOSUPPORT               43
#define EPROTOTYPE                    41
#define ERANGE                        34
#define ESHUTDOWN                     58
#define ESOCKTNOSUPPORT               44
#define ETIMEDOUT                     60
#define ETOOMANYREFS                  59
#define EWOULDBLOCK                   35
#define E2BIG                         7
#define EILSEQ                        92
/*

   ----------------------
   -- Terminal control --
   ----------------------

*/
#define TCSANOW                       0
#define TCIFLUSH                      1
#define IXON                          512
#define CLOCAL                        32768
#define CRTSCTS                       196608
#define CREAD                         2048
#define CS5                           0
#define CS6                           256
#define CS7                           512
#define CS8                           768
#define CSTOPB                        1024
#define PARENB                        4096
#define PARODD                        8192
#define B0                            0
#define B50                           50
#define B75                           75
#define B110                          110
#define B134                          134
#define B150                          150
#define B200                          200
#define B300                          300
#define B600                          600
#define B1200                         1200
#define B1800                         1800
#define B2400                         2400
#define B4800                         4800
#define B9600                         9600
#define B19200                        19200
#define B38400                        38400
#define B57600                        57600
#define B115200                       115200
#define B230400                       230400
#define B460800                       4294967295
#define B500000                       4294967295
#define B576000                       4294967295
#define B921600                       4294967295
#define B1000000                      4294967295
#define B1152000                      4294967295
#define B1500000                      4294967295
#define B2000000                      4294967295
#define B2500000                      4294967295
#define B3000000                      4294967295
#define B3500000                      4294967295
#define B4000000                      4294967295
/*

   ---------------------------------
   -- Terminal control characters --
   ---------------------------------

*/
#define VINTR                         8
#define VQUIT                         9
#define VERASE                        3
#define VKILL                         5
#define VEOF                          0
#define VTIME                         17
#define VMIN                          16
#define VSWTC                         -1
#define VSTART                        12
#define VSTOP                         13
#define VSUSP                         10
#define VEOL                          1
#define VREPRINT                      6
#define VDISCARD                      15
#define VWERASE                       4
#define VLNEXT                        14
#define VEOL2                         2
/*

   -----------------------------
   -- Pseudo terminal library --
   -----------------------------

*/
#define PTY_Library                   ""
/*

   --------------
   -- Families --
   --------------

*/
#define AF_INET                       2
#define AF_INET6                      30
#define AF_UNSPEC                     0
/*

   -----------------------------
   -- addrinfo fields offsets --
   -----------------------------

*/
#define AI_FLAGS_OFFSET               0
#define AI_FAMILY_OFFSET              4
#define AI_SOCKTYPE_OFFSET            8
#define AI_PROTOCOL_OFFSET            12
#define AI_ADDRLEN_OFFSET             16
#define AI_ADDR_OFFSET                32
#define AI_CANONNAME_OFFSET           24
#define AI_NEXT_OFFSET                40
/*

   ---------------------------------------
   -- getaddrinfo getnameinfo constants --
   ---------------------------------------

*/
#define AI_PASSIVE                    1
#define AI_CANONNAME                  2
#define AI_NUMERICSERV                4096
#define AI_NUMERICHOST                4
#define AI_ADDRCONFIG                 1024
#define AI_V4MAPPED                   2048
#define AI_ALL                        256
#define NI_NAMEREQD                   4
#define NI_DGRAM                      16
#define NI_NOFQDN                     1
#define NI_NUMERICSERV                8
#define NI_NUMERICHOST                2
#define NI_MAXHOST                    1025
#define NI_MAXSERV                    32
#define EAI_SYSTEM                    11
/*

   ------------------
   -- Socket modes --
   ------------------

*/
#define SOCK_STREAM                   1
#define SOCK_DGRAM                    2
#define SOCK_RAW                      3
/*

   -----------------
   -- Host errors --
   -----------------

*/
#define HOST_NOT_FOUND                1
#define TRY_AGAIN                     2
#define NO_DATA                       4
#define NO_RECOVERY                   3
/*

   --------------------
   -- Shutdown modes --
   --------------------

*/
#define SHUT_RD                       0
#define SHUT_WR                       1
#define SHUT_RDWR                     2
/*

   ---------------------
   -- Protocol levels --
   ---------------------

*/
#define SOL_SOCKET                    65535
#define IPPROTO_IP                    0
#define IPPROTO_IPV6                  41
#define IPPROTO_UDP                   17
#define IPPROTO_TCP                   6
#define IPPROTO_ICMP                  1
#define IPPROTO_IGMP                  2
#define IPPROTO_IPIP                  4
#define IPPROTO_EGP                   8
#define IPPROTO_PUP                   12
#define IPPROTO_IDP                   22
#define IPPROTO_TP                    29
#define IPPROTO_DCCP                  -1
#define IPPROTO_RSVP                  46
#define IPPROTO_GRE                   47
#define IPPROTO_ESP                   50
#define IPPROTO_AH                    51
#define IPPROTO_MTP                   92
#define IPPROTO_BEETPH                -1
#define IPPROTO_ENCAP                 98
#define IPPROTO_PIM                   103
#define IPPROTO_COMP                  -1
#define IPPROTO_SCTP                  132
#define IPPROTO_UDPLITE               -1
#define IPPROTO_MPLS                  -1
#define IPPROTO_RAW                   255
/*

   -------------------
   -- Request flags --
   -------------------

*/
#define MSG_OOB                       1
#define MSG_PEEK                      2
#define MSG_EOR                       8
#define MSG_WAITALL                   64
#define MSG_NOSIGNAL                  -1
#define MSG_Forced_Flags              0
/*
   --  Flags set on all send(2) calls
*/
/*

   --------------------
   -- Socket options --
   --------------------

*/
#define TCP_NODELAY                   1
#define SO_REUSEADDR                  4
#define SO_REUSEPORT                  512
#define SO_KEEPALIVE                  8
#define SO_LINGER                     128
#define SO_BROADCAST                  32
#define SO_SNDBUF                     4097
#define SO_RCVBUF                     4098
#define SO_SNDTIMEO                   4101
#define SO_RCVTIMEO                   4102
#define SO_ERROR                      4103
#define SO_BUSY_POLL                  -1
#define IP_MULTICAST_IF               9
#define IP_MULTICAST_TTL              10
#define IP_MULTICAST_LOOP             11
#define IP_ADD_MEMBERSHIP             12
#define IP_DROP_MEMBERSHIP            13
#define IP_PKTINFO                    26
#define IP_RECVERR                    -1
#define IPV6_ADDRFORM                 -1
#define IPV6_ADD_MEMBERSHIP           -1
#define IPV6_DROP_MEMBERSHIP          -1
#define IPV6_MTU                      -1
#define IPV6_MTU_DISCOVER             -1
#define IPV6_MULTICAST_HOPS           10
#define IPV6_MULTICAST_IF             9
#define IPV6_MULTICAST_LOOP           11
#define IPV6_RECVPKTINFO              -1
#define IPV6_PKTINFO                  -1
#define IPV6_RTHDR                    -1
#define IPV6_AUTHHDR                  -1
#define IPV6_DSTOPTS                  -1
#define IPV6_HOPOPTS                  -1
#define IPV6_FLOWINFO                 -1
#define IPV6_HOPLIMIT                 -1
#define IPV6_RECVERR                  -1
#define IPV6_ROUTER_ALERT             -1
#define IPV6_UNICAST_HOPS             4
#define IPV6_V6ONLY                   27
/*

   ----------------------
   -- Type definitions --
   ----------------------

*/
/*
   --  Sizes (in bytes) of the components of struct timeval
*/
#define SIZEOF_tv_sec                 8
#define SIZEOF_tv_usec                4
/*

   --  Maximum allowed value for tv_sec
*/
#define MAX_tv_sec                    2 ** (SIZEOF_tv_sec * 8 - 1) - 1
/*

   --  Sizes of various data types
*/
#define SIZEOF_sockaddr_in            16
#define SIZEOF_sockaddr_in6           28
#define SIZEOF_fd_set                 128
#define FD_SETSIZE                    1024
#define SIZEOF_struct_hostent         32
#define SIZEOF_struct_servent         32
#define SIZEOF_socklen_t              4
#define IF_NAMESIZE                   -1
/*

   --  Fields of struct msghdr
*/
#define Msg_Iovlen_T Interfaces.C.size_t
/*

   ----------------------------------------
   -- Properties of supported interfaces --
   ----------------------------------------

*/
#define Need_Netdb_Buffer             0
#define Need_Netdb_Lock               0
#define Has_Sockaddr_Len              1
#define Thread_Blocking_IO            True
/*
   --  Set False for contexts where socket i/o are process blocking

*/
#define Inet_Pton_Linkname            "inet_pton"
#define Inet_Ntop_Linkname            "inet_ntop"
/*

   ---------------------
   -- Threads support --
   ---------------------

   --  Clock identifier definitions

*/
#define CLOCK_REALTIME                0
#define CLOCK_MONOTONIC               6
#define CLOCK_THREAD_CPUTIME_ID       16
#define CLOCK_RT_Ada                  CLOCK_REALTIME
/*

   --  Sizes of pthread data types
*/
/*
   --  (on Darwin, these are just placeholders)
*/
/*

*/
#define PTHREAD_SIZE                  8176
#define PTHREAD_ATTR_SIZE             56
#define PTHREAD_MUTEXATTR_SIZE        8
#define PTHREAD_MUTEX_SIZE            56
#define PTHREAD_CONDATTR_SIZE         8
#define PTHREAD_COND_SIZE             40
#define PTHREAD_RWLOCKATTR_SIZE       16
#define PTHREAD_RWLOCK_SIZE           192
#define PTHREAD_ONCE_SIZE             8
/*

   --------------------------------
   -- File and directory support --
   --------------------------------

*/
#define SIZEOF_struct_file_attributes 32
#define SIZEOF_struct_dirent_alloc    277
/*

end System.OS_Constants;
*/
