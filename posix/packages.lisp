;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-
;;;
;;; packages.lisp --- Package definitions.
;;;
;;; Copyright (C) 2007, Luis Oliveira  <loliveira@common-lisp.net>
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without
;;; restriction, including without limitation the rights to use, copy,
;;; modify, merge, publish, distribute, sublicense, and/or sell copies
;;; of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.

(in-package #:cl-user)

(defpackage #:osicat-posix
  (:use #:common-lisp #:cffi #:osicat-sys #:alexandria
        #-(and) #:osicat-posix-internals)
  (:shadow #:open #:close #:read #:write #:truncate #:ftruncate #:sleep #:time)
  ;; Unfortunately, POSIX and UNIX are already taken by CLISP and
  ;; CMUCL.  Nickname suggestions are welcome.  CPOSIX?  SUS?  SUS3?
  (:nicknames #:nix)
  (:export
   ;; Conditions
   #:posix-error

   #:eperm #:enoent #:esrch #:eintr #:eio #:enxio #:e2big #:enoexec #:ebadf
   #:echild #:eagain #:enomem #:eacces #:efault #:enotblk #:ebusy #:eexist
   #:exdev #:enodev #:enotdir #:eisdir #:einval #:enfile #:emfile #:enotty
   #:etxtbsy #:efbig #:enospc #:espipe #:erofs #:emlink #:epipe #:edom
   #:erange #:edeadlk #:enametoolong #:enolck #:enosys #:enotempty #:eloop
   #:ewouldblock #:enomsg #:eidrm #:enostr #:enodata #:etime #:enosr
   #:eremote #:enolink #:eproto #:emultihop #:ebadmsg #:eoverflow #:eilseq
   #:eusers #:enotsock #:edestaddrreq #:emsgsize #:eprototype #:enoprotoopt
   #:eprotonosupport #:esocktnosupport #:eopnotsupp #:epfnosupport
   #:eafnosupport #:eaddrinuse #:eaddrnotavail #:enetdown #:enetunreach
   #:enetreset #:econnaborted #:econnreset #:enobufs #:eisconn #:enotconn
   #:eshutdown #:etoomanyrefs #:etimedout #:econnrefused #:ehostdown
   #:ehostunreach #:ealready #:einprogress #:estale #:edquot #:enonet

   ;; Functions
   #:access
   #:bzero
   #:chdir
   #:chmod
   #:clock-getres
   #:clock-gettime
   #:clock-settime
   #:close
   #:closedir
   #:closelog
   #:creat
   #:dirfd
   #:dup
   #:dup2
   #:fchdir
   #:fchmod
   #:fcntl
   #:fork
   #:fstat
   #:fstatvfs
   #:fsync
   #:ftruncate
   #:gai-strerror
   #:getcwd
   #:getdomainname
   #:getegid
   #:getenv
   #:geteuid
   #:getgid
   #:getgrgid
   #:getgrnam
   #:gethostname
   #:getpagesize
   #:getpgid
   #:getpgrp
   #:getpid
   #:getppid
   #:getpriority
   #:getpwnam
   #:getpwuid
   #:getrlimit
   #:getrusage
   #:gettimeofday
   #:getuid
   #:ioctl
   #:link
   #:lockf
   #:lseek
   #:lstat
   #:memcpy
   #:memset
   #:memmove
   #:mkdir
   #:mkdtemp
   #:mkfifo
   #:mknod
   #:mkstemp
   #:mlock
   #:mlockall
   #:mmap
   #:mprotect
   #:msync
   #:munlock
   #:munlockall
   #:munmap
   #:nice
   #:open
   #:opendir
   #:openlog
   #:pipe
   #:poll
   #:pread
   #:pwrite
   #:read
   #:readdir
   #:readlink
   #:readv
   #:rename
   #:rewinddir
   #:rmdir
   #:seekdir
   #:select
   #:setegid
   #:setenv
   #:seteuid
   #:setgid
   #:setlogmask
   #:setpgid
   #:setpgrp
   #:setpriority
   #:setregid
   #:setreuid
   #:setrlimit
   #:setsid
   #:setuid
   #:sleep
   #:stat
   #:statvfs
   #:strerror
   #:symlink
   #:sync
   #:sysconf
   #:syslog
   #:telldir
   #:time
   #:tmpnam
   #:truncate
   #:umask
   #:uname
   #:unlink
   #:unsetenv
   #:usleep
   #:write
   #:writev

   ;; Functions (wrapping C macros)
   #:log-mask
   #:log-upto
   #:s-isreg
   #:s-isdir
   #:s-ischr
   #:s-isblk
   #:s-isfifo
   #:s-islnk
   #:s-issock
   ;; #:fileno

   ;; Select Helpers
   #:copy-fd-set
   #:fd-clr
   #:fd-isset
   #:fd-set
   #:fd-zero
   #:select-file-descriptor             ; type

   ;; Special Variables
   #:*environ*

   ;; Other Functions
   #:fd-open-p
   #:get-errno
   #:set-errno

   ;; Types and Accessors
   #:stat
   #:stat-dev
   #:stat-ino
   #:stat-mode
   #:stat-nlink
   #:stat-uid
   #:stat-gid
   #:stat-rdev
   #:stat-size
   #:stat-blksize
   #:stat-blocks
   #:stat-atime
   #:stat-mtime
   #:stat-ctime

   ;; Platform-specific Functions

   #+linux #:fdatasync
   #+linux #:epoll-create
   #+linux #:epoll-ctl
   #+linux #:epoll-wait

   #+bsd #:kqueue
   #+bsd #:kevent
   #+bsd #:ev-set

   ;; Constants

   #:sighup #:sigint #:sigquit #:sigill #:sigtrap #:sigabrt #:sigemt #:sigfpe
   #:sigkill #:sigbus #:sigsegv #:sigsys #:sigpipe #:sigalrm #:sigterm #:sigurg
   #:sigstop #:sigtstp #:sigcont #:sigchld #:sigttin #:sigttou #:sigio #:sigxcpu
   #:sigxfsz #:sigvtalrm #:sigprof #:sigwinch #:siginfo #:sigusr1 #:sigusr2
   #:sigrtmin #:sigrtmax

   #:o-rdonly #:o-wronly #:o-rdwr #:o-creat #:o-excl #:o-noctty #:o-trunc
   #:o-append #:o-nonblock #:o-ndelay #:o-sync #:o-nofollow #:o-direct
   #:o-async #:o-directory #:o-largefile #:o-dsync #:o-rsync

   #:f-dupfd #:f-getfd #:f-setfd #:f-getfl #:f-setfl #:f-getlk #:f-setlk
   #:f-setlkw #:f-getown #:f-setown #:f-rdlck #:f-wrlck #:f-unlck #:f-getsig
   #:f-setsig #:f-setlease #:f-getlease

   #:seek-set #:seek-cur #:seek-end

   #:r-ok #:w-ok #:x-ok #:f-ok

   #:f-lock #:f-tlock #:f-ulock #:f-test

   #:prot-none #:prot-read #:prot-write #:prot-exec #:map-shared #:map-private
   #:map-fixed #:map-failed #:map-noreserve #:map-locked #:map-growsdown
   #:map-anon #:map-anonymous #:map-32bit #:map-populate #:map-nonblock
   #:map-anon #:map-hassemaphore #:map-inherit #:map-nocore #:map-nosync
   #:map-stack

   #:ms-async #:ms-sync #:ms-invalidate

   #:mcl-current #:mcl-future

   #:s-irwxu #:s-irusr #:s-iwusr #:s-ixusr #:s-irwxg #:s-irgrp #:s-iwgrp
   #:s-ixgrp #:s-irwxo #:s-iroth #:s-iwoth #:s-ixoth #:s-isuid #:s-isgid
   #:s-isvtx #:s-ifmt #:s-ififo #:s-ifchr #:s-ifdir #:s-ifblk #:s-ifreg
   #:s-iflnk #:s-ifsock #:s-ifwht #:s-iread #:s-iwrite #:s-iexec

   #:path-max

   #:sc-aio-listio-max #:sc-aio-max #:sc-aio-prio-delta-max #:sc-arg-max
   #:sc-atexit-max #:sc-bc-base-max #:sc-bc-dim-max #:sc-bcscale-max
   #:sc-bc-string-max #:sc-child-max #:sc-clk-tck #:sc-coll-weights-max
   #:sc-delaytimer-max #:sc-expr-nest-max #:sc-host-name-max #:sc-iov-max
   #:sc-line-max #:sc-login-name-max #:sc-ngroups-max #:sc-getgr-r-size-max
   #:sc-getpw-r-size-max #:sc-mq-open-max #:sc-mq-prio-max #:sc-open-max
   #:sc-advisory-info #:sc-barriers #:sc-asynchronous-io #:sc-clock-selection
   #:sc-cputime #:sc-file-locking #:sc-fsync #:sc-ipv6 #:sc-job-control
   #:sc-mapped-files #:sc-memlock #:sc-memlock-range #:sc-memory-protection
   #:sc-message-passing #:sc-monotonic-clock #:sc-multi-process
   #:sc-prioritized-io #:sc-priorityscheduling #:sc-raw-sockets
   #:sc-reader-writer-locks #:sc-realtime-signals #:sc-regexp #:sc-saved-ids
   #:sc-semaphores #:sc-shared-memory-objects #:sc-shell #:sc-spawn
   #:sc-spin-locks #:sc-sporadic-server #:sc-symloop-max #:sc-synchronized-io
   #:sc-thread-attr-stackaddr #:sc-thread-attr-stacksize #:sc-thread-cputime
   #:sc-thread-prio-inherit #:sc-thread-prio-protect
   #:sc-thread-priorityscheduling #:sc-thread-process-shared
   #:sc-thread-safe-functions #:sc-thread-sporadic-server #:sc-threads
   #:sc-timeouts #:sc-timers #:sc-trace #:sc-trace-event-filter
   #:sc-trace-inherit #:sc-trace-log #:sc-typed-memory-objects #:sc-version
   #:sc-v6-ilp32-off32 #:sc-v6-ilp32-offbig #:sc-v6-lp64-off64
   #:sc-v6-lpbig-offbig #:sc-2-c-bind #:sc-2-c-dev #:sc-2-c-version
   #:sc-2-char-term #:sc-2-fort-dev #:sc-2-fort-run #:sc-2-localedef
   #:sc-2-pbs #:sc-2-pbs-accounting #:sc-2-pbs-checkpoint #:sc-2-pbs-locate
   #:sc-2-pbs-message #:sc-2-pbs-track #:sc-2-sw-dev #:sc-2-upe #:sc-2-version
   #:sc-regex-version #:sc-page-size #:sc-pagesize
   #:sc-thread-destructor-iterations #:sc-thread-keys-max #:sc-thread-stack-min
   #:sc-thread-threads-max #:sc-re-dup-max #:sc-rtsig-max #:sc-sem-nsems-max
   #:sc-sem-value-max #:sc-sigqueue-max #:sc-stream-max #:sc-symloop-max
   #:sc-timer-max #:sc-tty-name-max #:sc-tzname-max #:sc-xbs5-ilp32-off32
   #:sc-xbs5-ilp32-offbig #:sc-xbs5-lp64-off64 #:sc-xbs5-lpbig-offbig
   #:sc-xopen-crypt #:sc-xopen-enh-i18n #:sc-xopen-legacy #:sc-xopen-realtime
   #:sc-xopen-realtime-threads #:sc-xopen-shm #:sc-xopen-streams
   #:sc-xopen-unix #:sc-xopen-version #:sc-xopen-xcu-version

   #:iov-max

   #:clock-monotonic #:clock-realtime

   #:log-cons #:log-ndelay #:log-perror #:log-pid

   #:prio-process #:prio-pgrp #:prio-user #:rlim-infinity #:rlim-saved-max
   #:rlim-saved-cur #:rusage-self #:rusage-children #:rlimit-as #:rlimit-core
   #:rlimit-cpu #:rlimit-data #:rlimit-fsize #:rlimit-memlock #:rlimit-nofile
   #:rlimit-nproc #:rlimit-rss #:rlimit-stack #:rlimit-locks #:rlimit-msgqueue
   #:rlimit-nlimits #:rlimit-nice #:rlimit-rtprio #:rlimit-sigpending
   #:rlimit-sbsize

   #:st-rdonly #:st-nosuid #:st-nodev #:st-noexec #:st-synchronous #:st-mandlock
   #:st-write #:st-append #:st-immutable #:st-noatime #:st-nodiratime

   #:pollin #:pollrdnorm #:pollrdband #:pollpri #:pollout #:pollwrnorm
   #:pollwrband #:pollerr #:pollrdhup #:pollhup #:pollnval

   #:epollin #:epollrdnorm #:epollrdband #:epollpri #:epollout #:epollwrnorm
   #:epollwrband #:epollerr #:epollhup #:epollmsg #:epolloneshot #:epollet
   #:epoll-ctl-add #:epoll-ctl-del #:epoll-ctl-mod

   #:ev-add #:ev-enable #:ev-disable #:ev-delete #:ev-oneshot #:ev-clear
   #:ev-eof #:ev-error #:evfilt-read #:evfilt-write #:evfilt-aio #:evfilt-vnode
   #:evfilt-proc #:evfilt-signal #:evfilt-timer #:evfilt-netdev #:note-delete
   #:note-write #:note-extend #:note-attrib #:note-link #:note-rename
   #:note-revoke #:note-exit #:note-fork #:note-exec #:note-track
   #:note-trackerr #:note-linkup #:note-linkdown #:note-linkinv

   #:dt-unknown #:dt-fifo #:dt-chr #:dt-dir #:dt-blk #:dt-reg #:dt-lnk
   #:dt-sock #:dt-wht

   #:siocgifname #:siocsiflink #:siocgifconf #:siocgifflags #:siocsifflags
   #:siocgifaddr #:siocsifaddr #:siocgifdstaddr #:siocsifdstaddr
   #:siocgifbrdaddr #:siocsifbrdaddr #:siocgifnetmask #:siocsifnetmask
   #:siocgifmetric #:siocsifmetric #:siocgifmem #:siocsifmem #:siocgifmtu
   #:siocsifmtu #:siocsifname #:siocsifhwaddr #:siocgifencap #:siocsifencap
   #:siocgifhwaddr #:siocgifslave #:siocsifslave #:siocaddmulti #:siocdelmulti
   #:siocgifindex #:siogifindex #:siocsifpflags #:siocgifpflags #:siocdifaddr
   #:siocsifhwbroadcast #:siocgifcount #:siocgifbr #:siocsifbr #:siocgiftxqlen
   #:siocsiftxqlen #:siocdarp #:siocgarp #:siocsarp #:siocdrarp #:siocgrarp
   #:siocsrarp #:siocgifmap #:siocsifmap #:siocadddlci #:siocdeldlci
   #:siocdevprivate #:siocprotoprivate #:tcgets #:tcsets #:tcsetsw #:tcsetsf
   #:tcgeta #:tcseta #:tcsetaw #:tcsetaf #:tcsbrk #:tcxonc #:tcflsh #:tiocexcl
   #:tiocnxcl #:tiocsctty #:tiocgpgrp #:tiocspgrp #:tiocoutq #:tiocsti
   #:tiocgwinsz #:tiocswinsz #:tiocmget #:tiocmbis #:tiocmbic #:tiocmset
   #:tiocgsoftcar #:tiocssoftcar #:fionread #:tiocinq #:tioclinux #:tioccons
   #:tiocgserial #:tiocsserial #:tiocpkt #:fionbio #:tiocnotty #:tiocsetd
   #:tiocgetd #:tcsbrkp #:tiocsbrk #:tioccbrk #:tiocgsid #:tiocgptn #:tiocsptlck
   #:fionclex #:fioclex #:fioasync #:tiocserconfig #:tiocsergwild
   #:tiocserswild #:tiocglcktrmios #:tiocslcktrmios #:tiocsergstruct
   #:tiocsergetlsr #:tiocsergetmulti #:tiocsersetmulti #:tiocmiwait
   #:tiocgicount #:tiocghayesesp #:tiocshayesesp #:fioqsize

   ;; Misc
   #:repeat-upon-condition
   #:repeat-upon-eintr
   #:repeat-upon-condition
   #:repeat-upon-condition-decreasing-timeout
   ))