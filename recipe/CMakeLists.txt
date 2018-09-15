project(symmetrica)
cmake_minimum_required(VERSION 2.8)
enable_language(C)

set(SOURCES
    bar.c bi.c boe.c bruch.c classical.c de.c di.c ff.c galois.c
    ga.c gra.c hash.c hiccup.c io.c ko.c list.c lo.c ma.c mee.c
    mem.c mes.c mhe.c mhh.c mhm.c mhp.c mhs.c mmm.c mms.c
    mod_dg_sbd.c mo.c mpp.c mps.c mse.c msh.c msm.c mss.c muir.c
    na.c nb.c nc.c nu.c part.c pee.c peh.c pem.c perm.c pes.c
    phe.c phh.c phm.c phs.c plet.c pme.c pmh.c poly.c ppe.c pph.c
    ppm.c ppp.c pps.c pr.c pse.c psh.c psm.c pss.c rest.c rh.c
    sab.c sb.c sc.c sr.c ta.c teh.c tem.c tep.c tes.c the.c thm.c
    thp.c ths.c tme.c tmh.c tmp.c tms.c tpe.c tph.c tpm.c tps.c
    tse.c tsh.c tsm.c tsp.c vc.c zo.c zykelind.c zyk.c
)

set(HEADERS
    def.h macro.h
)

add_library(symmetrica STATIC ${SOURCES})
target_include_directories(symmetrica PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(symmetrica PRIVATE -DFAST -DALLTRUE)
if (NOT WIN32)
    target_link_libraries(symmetrica -lm)
endif()

add_executable(test test.c)
target_link_libraries(test PRIVATE symmetrica)

install(TARGETS symmetrica
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(FILES ${HEADERS} DESTINATION include/symmetrica)