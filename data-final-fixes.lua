local FUN = require("__pycoalprocessing__/prototypes/functions/functions")

if mods.pyalternativeenergy then -- used in turd upgrade zipir path 3
  local recipe = table.deepcopy(data.raw.recipe['zipir1-pyvoid'])
  recipe.name = 'zipir1-pyvoid-hatchery'
  recipe.icons = nil
  recipe.icon = '__pyhightechgraphics__/graphics/icons/rendering.png'
  recipe.icon_size = 32
  recipe.results = {{type = 'item', name = 'processed-ash', probability = 0.8, amount = 1}}
  data:extend{recipe}
end

--ADAPTATIONS

for _, drill in pairs(data.raw['mining-drill']) do
  if drill.module_specification then
	  drill.allowed_effects = {"consumption", "speed", "productivity"}
  else
    drill.allowed_effects = {"consumption", "productivity"}
  end
end

local recipes_list =
	{
  "mosfet",
  "zogna-bacteria",
  "zogna-bacteria-darkness",
  "formamide",
  "artificial-blood",
  "fish-oil",
  "manure-bacteria",
  "manure-bacteria-fish",
  "liquid-manure",
  "formic-acid",
  "biomass-1",
  "biomass-2",
  "wood-seedling",
  "wood-seeds",
  "coke-co2",
  "agar",
  "petri-dish",
  "moss-gen",
  "cage",
  "neuroprocessor",
  "py-science-pack-1",
  "py-science-pack-1-turd",
  "py-science-pack-2",
  "py-science-pack-2-turd",
  "py-science-pack-3",
  "py-science-pack-3-turd",
  "py-science-pack-4",
  "py-science-pack-4-turd",
  "fertilizer-1",
  "fertilizer-4",
  "flutec-pp6",
  "cobalt-fluoride",
  "decalin",
  "flavonoids",
  "cytostatics",
  "microcin-j25",
  "lard-from-brains",
  "hcl-from-guts",
  "olechemicals-from-skin",
  "pelt-processing",
  "mixed-ores",
  "cobalt-extract",
  "cobalt-sulfate",
  "cobalt-sulfate-02",
  "cobalt-oxide",
  "cobalt-nx",
  "dried-grods",
  "zymogens",
  "mmp",
  "peptidase-m58",
  "alien-enzymes",
  "nitrogen-mustard",
  "pacifastin",
  "hyaline",
  "cellulose-00",
  "cellulose-02",
  "lignin",
  "lignin-to-aromatics",
  "pheromones",
  "neuromorphic-chip",
  "nano-cellulose",
  "gasoline-cellulose",
  "filtration-media-3",
  "cellulose-gasification",
  "yotoi-cellulose",
  "manure-to-biomass",
  "manure-to-crude",
  "sodium-alginate",
  "latex-slab",
  "latex",
  "stopper",
  "bio-container",
  "naven-coal",
  "oleochemical-combustion",
  "fish-oil-combustion",
  "lard-combustion",
  "ethanol-combustion",
  "syrup-01",
  "energy-drink",
  "energy-drinkb",
  "sweet-syrup",
  "sugar",
  "ethanol",
  "lime-from-shell",
  "replicator-bioreserve",
  "oleochemicals-3",
  "blood-to-iron",
  "meat-to-iron",
  "meat-and-gut-to-copper",
  "arthropod-blood-to-copper",
  "arthropod-blood-to-organic-solvent",
  "tuuphra-to-copper",
  "meat-to-copper",
  "guts-to-copper",
  "fish-to-iron",
  "tuupha-to-iron",
  "fawogae-to-iron",
  "fish-to-tin",
  "meat-to-nitrogen",
  "guts-to-chlorine",
  "blood-to-chlorine",
  "brain-guts-to-zinc",
  "grod-to-zinc",
  "blood-to-zinc",
  "bhoddos-to-ti",
  "navens-to-ti",
  "yaedol-to-sulfur",
  "fawogae-to-sulfur",
  "rennea-to-copper",
  "yaedols-to-copper",
  "brain-to-zinc",
  "guts-to-zinc",
  "carapace-to-al",
  "spikes-to-mo",
  "tuuphra-to-mo",
  "cridren-seeds-to-mo",
  "yotoi-leaves-to-chromium",
  "yotoi-fruit-to-chromium",
  "meat-to-chromium",
  "yotoi-seed-to-chromium",
  "meat-to-tin",
  "yotoi-fruit-to-tin",
  "grod-to-tin",
  "navens-to-tin",
  "manure-to-nitrogen",
  "fawogae-spore",
  "plasmids",
  "retrovirus",
  "retrovirus-2",
  "cdna",
  "primers",
  "dna-polymerase",
  "dna-polymerase-2",
  "alien-sample-02",
  "alien-sample-03",
  "gta",
  "cysteine",
  "adam42-gen",
  "adam42-gen-laser",
  "zinc-finger-proteins",
  "propeptides",
  "purine-analogues",
  "immunosupressants",
  "dynemicin",
  "enediyne",
  "enzyme-pks",
  "recombinant-ery",
  "recombinant-ery-2",
  "recombinant-ery-3",
  "fetal-serum-01",
  "vrauks",
  "earth-generic-sample",
  "vrauks-food-01",
  "vrauks-food-02",
  "cottongut-food-01",
  "cottongut-food-02",
  "cottongut-food-03",
  "korlex-food-01",
  "korlex-food-02",
  "ulric",
  "earth-horse-sample",
  "ulric-food-01",
  "ulric-food-02",
  "sea-sponge",
  "earth-sea-sponge-sample",
  "sea-sponge-processing-01",
  "sea-sponge-sprouts-processing-01",
  "sea-sponge-sprouts",
  "sea-sponge-sprouts-2",
  "sea-sponge-sprouts-3",
  "sea-sponge-sprouts-4",
  "ralesia-sample",
  "ralesia-seeds-paper-towel",
  "earth-flower-sample",
  "replicator-ralesia",
  "mukmoux",
  "earth-cow-sample",
  "mukmoux-food-01",
  "mukmoux-food-02",
  "tuuphra-sample",
  "earth-potato-sample",
  "tuuphra-seeds",
  "replicator-tuuphra",
  "arthurian",
  "earth-lizard-sample",
  "arthurian-food-01",
  "arthurian-food-02",
  "arthurian-grow-01",
  "navens-sample",
  "navens-spore",
  "yotoi-sample",
  "earth-tropical-tree-sample",
  "yotoi-seeds",
  "yotoi-seeds-cold",
  "yotoi-leaves",
  "replicator-yotoi",
  "replicator-yotoi-fruit",
  "dhilmos",
  "dhilmos-grow-01",
  "dhilmos-food-01",
  "dhilmos-food-02",
  "scrondrix",
  "earth-roadrunner-sample",
  "rennea-sample",
  "earth-sunflower-sample",
  "rennea-seeds",
  "replicator-rennea",
  "phadai",
  "earth-tiger-sample",
  "phadai-food-01",
  "phadai-food-02",
  "auog",
  "earth-bear-sample",
  "auog-food-01",
  "auog-food-01-sawdust",
  "auog-food-02",
  "auog-food-02-sawdust",
  "fish-food-01",
  "fish-food-02",
  "yaedols-sample",
  "yaedols-spores",
  "earth-wolf-sample",
  "dingrits-food-01",
  "dingrits-food-02",
  "grod-sample",
  "earth-jute-sample",
  "earth-giraffe-sample",
  "phagnot-food-01",
  "phagnot-food-02",
  "bhoddos-sample",
  "cridren-sample",
  "earth-venus-fly-sample",
  "earth-crustacean-sample",
  "zipir-food-01",
  "zipir-food-02",
  "fertilizer-3",
  "kicalk-sample",
  "earth-palmtree-sample",
  "cadaveric-arum-sample",
  "antelope",
  "earth-antelope-sample",
  "bones-to-phosphate",
  "carapace-to-re",
  "meat-to-cyanic",
  "kicalk-to-iron",
  "cadaveric-to-sulfur",
  "cadaveric-to-copper",
  "blood-to-urea",
  "ethylene-from-fruit",
  "fiber-01",
  "phenol-02",
  "filtration-media-4",
  "kmauts-ration-chitin",
  "urea-from-liquid-manure",
  "kicalk-fiber",
  "methane-from-liquid-manure",
  "chithin-to-phosphate",
  "meat-to-phosphate",
  "fish-to-phosphate",
  "wood-seeds-to-phosphate",
  "rennea-to-phosphate",
  "biopolymer-2",
  "phenol-3",
  "organics-from-wood-2",
  "soil-separation-2",
  "biomass-1-a",
  "dried-grods-02",
  "gas-bladder-to-natura-gas",
  "concrete-02",
  "planter-box",
  "empty-planter-box",
  "biobattery",
  "cooling-system",
  "fiber-dry-storage",
  "log-wood-fast",
  "paper-towel",
  "lab-instrument-2",
  "workers-food",
  "workers-food-02",
  "workers-food-03",
  "simik-food-01",
  "simik-food-02"
	}

--adding to module limitation list
FUN.productivity(recipes_list)

local mod_cats =
  {
    "tree",
    "seaweed",
    "moss",
    "sap",
    "ulric",
    "sponge",
    "ralesia",
    "mukmoux",
    "tuuphra",
    "arthurian",
    "navens",
    "yotoi",
    "rennea",
    "dhilmos",
    "scrondrix",
    "phadai",
    "auog",
    "fish",
    "yaedols",
    "dingrits",
    "kmauts",
    "vonix",
    "grod",
    "phagnot",
    "bhoddos",
    "arqad",
    "xeno",
    "kicalk",
    "cridren",
    "antelope",
    "zipir",
    "trits",
    "arum",
    "vrauks",
    "xyhiphoe",
    "korlex",
    "fawogae",
    "moondrop",
    "cottongut",
    "guar"
  }

--log(serpent.block(data.raw.module['effectivity-module']))

--log(serpent.block(data.raw.module["moondrop"]))
