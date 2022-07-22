#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

params.indir = "/Users/vera/Learning/CQ/Internship/rki_subtyping_resistance/Subtyping/*.fasta"
params.outdir = "../myresults"

process stanford {
  publishDir "${params.outdir}", mode: "copy", overwrite: true
  
  input:
  
    path fastafile

  output:
    path "${fastafile.getSimpleName()}.json"
  
  script:
    """
    sierrapy fasta ${fastafile} -o ${fastafile.getSimpleName()}.json
  
    """
}

workflow {
    inputfastas = channel.fromPath(params.indir)
    stanfordChannel = stanford(inputfastas)
    stanfordChannel.view()
}

