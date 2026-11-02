# ============================================
# COMPILE
# ============================================

vlib work
vlog -sv top.sv

# ============================================
# OPTIMIZE WITH COVERAGE
# ============================================

vopt top +cover=fcbest -o top_optimized

# ============================================
# TEST 1: 1W
# ============================================

vsim -coverage top_optimized +test_name=1W +N=32
add wave -r sim:/top/pif/*
run -all
do vinod.do
coverage save 1W.ucdb
quit -sim

# ============================================
# TEST 2: 5W
# ============================================

vsim -coverage top_optimized +test_name=5W +N=32
run -all
coverage save 5W.ucdb
quit -sim

# ============================================
# TEST 3: 1W_1R
# ============================================

vsim -coverage top_optimized +test_name=1W_1R +N=32
run -all
coverage save 1W_1R.ucdb
quit -sim

# ============================================
# TEST 4: 5W_5R
# ============================================

vsim -coverage top_optimized +test_name=5W_5R +N=32
run -all
coverage save 5W_5R.ucdb
quit -sim

# ============================================
# TEST 5: NW_NR
# ============================================

vsim -coverage top_optimized +test_name=NW_NR +N=300
run -all
coverage save NW_NR.ucdb
quit -sim
# ============================================
# TEST 6: MISMATCHING
# ============================================

#vsim -coverage top_optimized +test_name=MIS +N=300
#run -all
#coverage save MIS.ucdb
#quit -sim

# ============================================
# TEST 7 : Unknown
# ============================================

vsim -coverage top_optimized +test_name=Unknown 
run -all
coverage save Unknown.ucdb
quit -sim


# ============================================
# MERGE ALL COVERAGE DATABASES
# ============================================

vcover merge -out final.ucdb \
    1W.ucdb \
    5W.ucdb \
    1W_1R.ucdb \
    5W_5R.ucdb \
    NW_NR.ucdb \
   #MIS.ucdb \
    Unknown.ucdb

# ============================================
# GENERATE FINAL COVERAGE REPORT
# ============================================

vcover report -details -all final.ucdb

# ============================================
# COMPLETION MESSAGE
# ============================================

puts "============================================"
puts "ALL FIVE TESTS COMPLETED"
puts "FINAL MERGED COVERAGE: final.ucdb"
puts "============================================"

