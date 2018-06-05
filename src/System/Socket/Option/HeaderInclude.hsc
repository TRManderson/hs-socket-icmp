module System.Socket.Option.HeaderInclude (
  HeaderInclude(..)
) where
import Data.Word
import System.Socket
import System.Socket.Unsafe

#ifdef mingw32_HOST_OS
#include <ws2tcpip.h>
type HdrInclType = Word32
#else
#include <netinet/in.h>
import Foreign.C.Types
type HdrInclType = CInt
#endif

-- |Represents the `IP_HDRINCL` option. 
-- It determines whether or not assume the IP header is included in any data sent over the socket
data HeaderInclude = HeaderInclude Bool deriving (Eq, Show)
instance SocketOption HeaderInclude where
  getSocketOption s =
    HeaderInclude . ((/=0) :: HdrInclType -> Bool) <$> unsafeGetSocketOption s 0 (#const IP_HDRINCL)
  setSocketOption s (HeaderInclude o) =
    unsafeSetSocketOption s 0 (#const IP_HDRINCL) (if o then 1 else 0 :: HdrInclType)