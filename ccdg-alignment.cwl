cwlVersion: cwl:draft-3
class: Workflow
inputs:
  - id: read_bam
    type: File

  - id: reference
    type: File

outputs:
  - id: aligned_cram
    type: File
    source: "#cram/aligned_cram"

steps:
  - id: bwa-mem
    run: bwa-mem.cwl
    inputs:
      - id: reference
        type: File
        source: "#reference"
      - id: reads
        source: "#read_bam"
      - id: minimum_seed_length
    outputs:
      - id: aligned_bam
  
#  - id: mark-duplicates
#    run: picard-markduplicates.cwl
#    inputs:
#      -id: inputFileName_markDups 
#    outputs:
#      -id: duplicate-marked_aligned_bam
#
#  - id: position-sort
#    run: samtools-sort.cwl
#    inputs:
#      - id: src
#        source: "#mark-duplicates/duplicate-marked_aligned_bam"
#    outputs:
#      - id: sorted_duplicate-marked_aligned_bam
#
#  - id: base-recalibrate
#    run: gatk-baserecalibrator.cwl
#    inputs:
#      - id: src
#        source: "#position-sort/sorted_duplicate-marked_aligned_bam"
#    outputs:
#      - id: recalibration_table
#
#  - id: apply-calibration
#    run: gatk-printreads.cwl
#    inputs:
#      - id: src
#        source: "#position-sort/sorted_duplicate-marked_aligned_bam"
#      - id: src
#        source: "#base-recalibrate/recalibration_table
#    outputs:
#      - id: recalibrated_sorted_duplicate-marked_aligned_bam
#
#  - id: cram
#    run: samtools-view.cwl
#    inputs:
#      - id: src
#        source: "#apply-calibration/recalibrated_sorted_duplicate-marked_aligned_bam"
#    outputs:
#      - id: recalibrated_sorted_duplicate-marked_aligned_cram
