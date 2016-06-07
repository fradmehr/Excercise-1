# load the data file in R Studio (step 0)
refine_original <- read.csv(file.choose())
attach(refine_original)
# clean of brand names (step 1)
refine_original$company[refine_original$company=="Phillips"] <- "philips"
refine_original$company[refine_original$company=="phillips"] <- "philips"
refine_original$company[refine_original$company=="philips"] <- "philips"
refine_original$company[refine_original$company=="Phllips"] <- "phllips"
refine_original$company[refine_original$company=="Phillps"] <- "philips"
refine_original$company[refine_original$company=="phillipS"] <- "philips"
refine_original$company[refine_original$company=="phlips"] <- "philips"
refine_original$company[refine_original$company=="akzo"] <- "akzo"
refine_original$company[refine_original$company=="Akzo"] <- "akzo"
refine_original$company[refine_original$company=="AKZO"] <- "akzo"
refine_original$company[refine_original$company=="akz0"] <- "akzo"
refine_original$company[refine_original$company=="ak zo"] <- "akzo"
refine_original$company[refine_original$company=="akzo"] <- "akzo"
refine_original$company[refine_original$company=="fillips"] <- "philips"
refine_original$company[refine_original$company=="Van Houten"] <- "van houten"
refine_original$company[refine_original$company=="van Houten"] <- "van houten"
refine_original$company[refine_original$company=="van houten"] <- "van houten"
refine_original$company[refine_original$company=="unilver"] <- "unilever"
refine_original$company[refine_original$company=="unilever"] <- "unilever"
refine_original$company[refine_original$company=="Unilver"] <- "unilever"
# Separate product code and number (step 2)
df <- data.frame(do.call('rbind',strsplit(as.character(refine_original$Product.code...number),'-',fixed=TRUE)))
refine_original_final <- cbind(refine_original,df)
refine_original_final$Product.code...number <- NULL
colnames(refine_original_final) <- c("company","address","city","country","name","product_code","product_number")
# Add product categories (step 3)
product_category <- c("Smartphone", "Smartphone", "Laptop", "Laptop", "Laptop", "Smartphone", "TV", "TV", "Laptop", "Smartphone", "Tablet", "Tablet", "Laptop", "Smartphone", "TV", "TV", "Laptop", "TV", "TV", "Laptop", "Smartphone", "Laptop", "Tablet", "Tablet", "Tablet")  
refine_original_final$category <- product_category
# Add full address for geocoding (step 4)
cols <- c('address','city','country')
refine_original_final$full_address <- apply( refine_original_final[ , cols ] , 1 , paste , collapse = "," )
# Create dummy variables for company and product category (step 5)
company_philips <- as.numeric(refine_original_final$company == "philips")
company_akzo <- as.numeric(refine_original_final$company == "akzo")
company_van_houten <- as.numeric(refine_original_final$company == "van houten")
company_unilever <- as.numeric(refine_original_final$company == "unilever")
product_smartphone <- as.numeric(refine_original_final$category == "Smartphone")
product_tv <- as.numeric(refine_original_final$category == "TV")
product_laptop <- as.numeric(refine_original_final$category == "Laptop")
product_tablet <- as.numeric(refine_original_final$category == "Tablet")
refine_original_final$company_philips <- company_philips
refine_original_final$company_akzo <- company_akzo
refine_original_final$company_unilever <- company_unilever 
refine_original_final$company_van_houten <- company_van_houten
refine_original_final$product_smartphone <- product_smartphone
refine_original_final$product_tv <- product_tv
refine_original_final$product_laptop <- product_laptop
refine_original_final$product_tablet <- product_tablet
# load the results in csv file
write.csv(refine_original_final,file="refine_clean.csv")