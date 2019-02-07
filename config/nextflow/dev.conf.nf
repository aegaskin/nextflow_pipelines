// PHW Nextflow Config


// ## *** GENERAL CONFIG *** ##

// # Output #
// Path to output directory (containing project directories)
outdir = '/mnt/datastore'

// Execute jobs locally
process.executor = 'local'


// # Singularity #
// Enable singularity containers
singularity.enabled = 'true'

// This should be set
singularity.autoMounts = 'true'

// Path to local singularity image directory
params.simgdir = 'config/singularity_images'

includeConfig 'dev_singularity.conf'


// ## *** QC PIPELINE CONFIG *** ##

// # Projects #
// Project list in groovy list format
params.projectlist = ['argab', 'argid', 'digcd', 'digid', 'flu', 'hiv', 'wcmtb', 'wcmid']


// # Output #
// Path to output directory (needed here to expose to nextflow script with "$params")
params.outdir = "${outdir}"

// # MultiQC #
// Path to multiqc conf yaml file [http://multiqc.info/docs/#configuring-multiqc]
params.multiqcconf = 'config/qc/multiqc_config.yaml'


// # Centrifuge #
// Path to directory containing centrifuge DB files, with fileglob specifying basename of the database
params.centrifugedbpath = 'config/qc/centrifuge_db/phw.*'

// NCBI TaxID for each project to count reads beneath - used in depth calculations
taxIDargab = 469
taxIDargid = 2
taxIDdigid = 2
taxIDdigcd = 1870884
taxIDflu = 11308
taxIDhiv = 11676
taxIDwcmtb = 77643
taxIDwcmid = 1762

params.taxIDdict = [['argab', taxIDargab],
                    ['argid', taxIDargid],
                    ['digcd', taxIDdigcd],
                    ['digid', taxIDdigid],
                    ['flu', taxIDflu],
                    ['hiv', taxIDhiv],
                    ['wcmtb', taxIDwcmtb],
                    ['wcmid', taxIDwcmid]]


// ## *** HIV PIPELINE CONFIG *** ##

// # Output #
// Path to project directory (made from outdir variable in GENERAL section)
params.hivdir = "${outdir}/hiv"

// # References and databases #
// Absolute path to HIV subtype reference sequences
params.subref = 'config/hiv/refs/hivcomp2015.fasta'

// Absolute path to HIV HXB2 reference sequence
params.HXB2ref = 'config/hiv/refs/HXB2.fasta'

// # Read cleaning and sampling #
// Sample bases target for subsampling
params.samplebases = '200000'


// # Shiver #
// Set default polishing strategy to shiver
params.shiver = 'true'

// Absolute path to Shiver InitDir (generated by shiver_init.sh) and shiver config.sh
params.shiverinit = 'config/hiv/shiver_init_HIV'
params.shiverconf = 'config/hiv/shiver_init_HIV/config.sh'


// # Variant calling strategy #
// Set default variant strategy (VarScan, BCFtools or LoFreq)
params.variantstrategy = 'VarScan'

// Set proportions at which to call variants (e.g. 0.2 == 20%)
params.minvarfreq = ['0.2', '0.1', '0.01']

// Set minor variant frequency at which to call resistance (must be one of the values in params.minvarfreq)
params.selectedminvarfreq = '0.2'


// ## *** FLU PIPELINE CONFIG *** ##

// # Output #
// Path to project directory (made from outdir variable in GENERAL section)
params.fludir = "${outdir}/flu"

// # References and databases #
// Absolute path to FLU segment reference fasta
params.flurefNA = 'config/flu/refs/flu-AuB.NA.fa' 
params.flurefHA = 'config/flu/refs/flu-AuB.HA.fa'
params.flurefM1 = 'config/flu/refs/flu-AuB.M1.fa'
params.flurefPB1 = 'config/flu/refs/flu-AuB.PB1.fa'
params.flurefPB2 = 'config/flu/refs/flu-AuB.PB2.fa'
params.flurefNP = 'config/flu/refs/flu-AuB.NP.fa'
params.flurefNS1 = 'config/flu/refs/flu-AuB.NS1.fa'
params.flurefPA = 'config/flu/refs/flu-AuB.PA.fa'

// Run Shiver on these segments - reference alignments and shiver_init directories required
params.shiversegs = [ 'NA', 'HA' , 'M1' ]

// Path to the shiver config.sh file used for flu
params.flushiverconf = 'config/flu/shiver_init_FLU/config.sh'

// Path to the root shiverinit directory for flu - the shiver_init directory for each segment should be within this, named with just the segment abbreviation
params.flushiverinitroot = 'config/flu/shiver_init_FLU'


// ## *** WCMTB PIPELINE CONFIG *** ##


// Upload WCM data (production profile ONLY)
params.wcmtransferupload = 'false'

// Panel to use for TB geno and resistance typing, choose from bradley-2015 or walker-2015
params.mykrobepanel = '201901'

// Path to directory containing WCM kraken database
params.wcmkrakendbdir = 'config/wcmid/mycobacterium_krakendb'


// ## *** ARGENT PIPELINE CONFIG *** ##
// DB to use for Abricate resistance
params.resistancedb = 'resfinder'

// DB to use for Abricate virulence
params.virulencedb = 'vfdb'


// ## *** DIGCD PIPELINE CONFIG *** ##
// Path to Mash sketches of reference sequences - used for placing samples into the database with the closest reference (smallest Mash dist)
params.digcdmashref = 'config/digcd/refs_minhash/digcdref.msh'

// Mash distance cutoff - any assemblies further than this distance from the closest reference will not be variant called
params.digcdmaxmashdist = '0.02'

// Path to directory containing snapperdb config files
params.digcdsnapperdbconfdir = 'config/digcd/snapperdb-conf'

// Path to directory containing snapperdb reference files
params.digcdsnapperdbrefdir = 'config/digcd/snapperdb-ref'

