project(symmetrica)
cmake_minimum_required(VERSION 2.8)
enable_language(C)
if (MSVC)
    # warning level 4
    add_compile_options(/Za)
endif()

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

option(BUILD_SHARED_LIBS "Build the shared library" OFF)

add_library(symmetrica ${SOURCES})
target_include_directories(symmetrica PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(symmetrica PRIVATE -DFAST -DALLTRUE)
if (NOT WIN32)
    target_link_libraries(symmetrica -lm)
endif()
set_property(TARGET symmetrica PROPERTY VERSION "2.0.0")
set_property(TARGET symmetrica PROPERTY SOVERSION 2 )

add_executable(test_symmetrica test.c)
target_link_libraries(test_symmetrica PRIVATE symmetrica)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/test_input.txt" "123")
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/test_output.txt"
"12.146304.367025.329675.766243.241881.295855.454217.088483.382315.
 328918.161829.235892.362167.668831.156960.612640.202170.735835.221294.
 047782.591091.570411.651472.186029.519906.261646.730733.907419.814952.
 960000.000000.000000.000000.000000")

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/run_test.cmake"
"
execute_process(COMMAND \${TEST_EXECUTABLE} INPUT_FILE \"\${TEST_INPUT_FILE}\"
         OUTPUT_VARIABLE TEST_OUTPUT)
string(STRIP \"\${TEST_OUTPUT}\" TEST_OUTPUT)
file(READ \"\${TEST_OUTPUT_FILE}\" TEST_OUTPUT_EXPECTED)
if (NOT \"\${TEST_OUTPUT}\" STREQUAL \"\${TEST_OUTPUT_EXPECTED}\")
    message(FATAL_ERROR \"Output not expected\")
endif()
")

enable_testing()
add_test(NAME run_test
         COMMAND ${CMAKE_COMMAND} "-DTEST_EXECUTABLE=$<TARGET_FILE:test_symmetrica>"
                 "-DTEST_INPUT_FILE=${CMAKE_CURRENT_BINARY_DIR}/test_input.txt"
                 "-DTEST_OUTPUT_FILE=${CMAKE_CURRENT_BINARY_DIR}/test_output.txt"
                 -P "${CMAKE_CURRENT_BINARY_DIR}/run_test.cmake")

include(GNUInstallDirs)

install(TARGETS symmetrica
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
)

install(FILES ${HEADERS} DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/symmetrica")
