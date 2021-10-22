Config = {}

-- Bank Tax Brackets
Config.HoboClassLimit  =  0
Config.PoorClassLimit  =  50000
Config.LowerClassLimit  =  150000
Config.LowerMiddleClassLimit = 250000
Config.MiddleClassLimit = 500000
Config.UpperMiddleClassLimit = 1000000
Config.LowerHigherClassLimit =  3000000
Config.HigherClassLimit =  6000000
Config.UpperHigherClassLimit =  12000000

-- Bank Tax Deductions (Multiplier)
Config.HoboClassTax  =  0
Config.PoorClassTax  =  1
Config.LowerClassTax  =  2
Config.LowerMiddleClassTax = 2
Config.MiddleClassTax =  2
Config.UpperMiddleClassTax =  3
Config.LowerHigherClassTax = 3
Config.HigherClassTax =  3
Config.UpperHigherClassTax = 4

-- Car Tax Deductions - example: $1000 tax for each car
Config.CarTax       = 1000
Config.CarTaxSuper  = 25000 -- Extra Car Tax for this category
Config.CarTaxSport  = 18000 -- Extra Car Tax for this category
Config.CarTaxSuv    = 16500 -- Extra Car Tax for this category
Config.CarTaxTuner  = 15000 -- Extra Car Tax for this category

-- Tax Interval
Config.TaxInterval = 180 * 60000 -- example: every hour