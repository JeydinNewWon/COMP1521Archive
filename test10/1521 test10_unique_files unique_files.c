FGETC(3)                                                 Linux Programmer's Manual                                                FGETC(3)

NNAAMMEE
       fgetc, fgets, getc, getchar, ungetc - input of characters and strings

SSYYNNOOPPSSIISS
       ##iinncclluuddee <<ssttddiioo..hh>>

       iinntt ffggeettcc((FFIILLEE **_s_t_r_e_a_m));;

       cchhaarr **ffggeettss((cchhaarr **_s,, iinntt _s_i_z_e,, FFIILLEE **_s_t_r_e_a_m));;

       iinntt ggeettcc((FFIILLEE **_s_t_r_e_a_m));;

       iinntt ggeettcchhaarr((vvooiidd));;

       iinntt uunnggeettcc((iinntt _c,, FFIILLEE **_s_t_r_e_a_m));;

DDEESSCCRRIIPPTTIIOONN
       ffggeettcc() reads the next character from _s_t_r_e_a_m and returns it as an _u_n_s_i_g_n_e_d _c_h_a_r cast to an _i_n_t, or EEOOFF on end of file or error.

       ggeettcc() is equivalent to ffggeettcc() except that it may be implemented as a macro which evaluates _s_t_r_e_a_m more than once.

       ggeettcchhaarr() is equivalent to ggeettcc((_s_t_d_i_n)).

       ffggeettss()  reads in at most one less than _s_i_z_e characters from _s_t_r_e_a_m and stores them into the buffer pointed to by _s.  Reading stops
       after an EEOOFF or a newline.  If a newline is read, it is stored into the buffer.  A terminating null byte ('\0') is stored after the
       last character in the buffer.

       uunnggeettcc() pushes _c back to _s_t_r_e_a_m, cast to _u_n_s_i_g_n_e_d _c_h_a_r, where it is available for subsequent read operations.  Pushed-back charac‐
       ters will be returned in reverse order; only one pushback is guaranteed.

       Calls to the functions described here can be mixed with each other and with calls to other input functions from the  _s_t_d_i_o  library
       for the same input stream.

       For nonlocking counterparts, see uunnlloocckkeedd__ssttddiioo(3).

RREETTUURRNN VVAALLUUEE
       ffggeettcc(), ggeettcc(), and ggeettcchhaarr() return the character read as an _u_n_s_i_g_n_e_d _c_h_a_r cast to an _i_n_t or EEOOFF on end of file or error.

       ffggeettss() returns _s on success, and NULL on error or when end of file occurs while no characters have been read.

       uunnggeettcc() returns _c on success, or EEOOFF on error.

AATTTTRRIIBBUUTTEESS
       For an explanation of the terms used in this section, see aattttrriibbuutteess(7).

       ┌──────────────────────────┬───────────────┬─────────┐
       │IInntteerrffaaccee                 │ AAttttrriibbuuttee     │ VVaalluuee   │
       ├──────────────────────────┼───────────────┼─────────┤
       │ffggeettcc(), ffggeettss(), ggeettcc(), │ Thread safety │ MT-Safe │
       │ggeettcchhaarr(), uunnggeettcc()       │               │         │
       └──────────────────────────┴───────────────┴─────────┘

CCOONNFFOORRMMIINNGG TTOO
       POSIX.1-2001, POSIX.1-2008, C89, C99.

       It  is not advisable to mix calls to input functions from the _s_t_d_i_o library with low-level calls to rreeaadd(2) for the file descriptor
       associated with the input stream; the results will be undefined and very probably not what you want.

SSEEEE AALLSSOO
       rreeaadd(2), wwrriittee(2), ffeerrrroorr(3), ffggeettwwcc(3), ffggeettwwss(3),  ffooppeenn(3),  ffrreeaadd(3),  ffsseeeekk(3),  ggeettlliinnee(3),  ggeettss(3),  ggeettwwcchhaarr(3),  ppuuttss(3),
       ssccaannff(3), uunnggeettwwcc(3), uunnlloocckkeedd__ssttddiioo(3), ffeeaattuurree__tteesstt__mmaaccrrooss(7)

CCOOLLOOPPHHOONN
       This  page is part of release 5.10 of the Linux _m_a_n_-_p_a_g_e_s project.  A description of the project, information about reporting bugs,
       and the latest version of this page, can be found at https://www.kernel.org/doc/man-pages/.

GNU                                                             2020-12-21                                                        FGETC(3)
