module System.Socket.Protocol.ICMP (
  ICMP(..)
) where
import System.Socket

#ifdef mingw32_HOST_OS
#include <ws2tcpip.h>
#else
#include <netinet/in.h>
#endif

-- |Represents the ICMP protocol (with the header IPPROTO_ICMP)
data ICMP
instance Protocol ICMP where protocolNumber _ = #const IPPROTO_ICMP