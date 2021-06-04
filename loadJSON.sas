
%macro loadJSON(files);

/* 
This file loads a series of JSON datasets into a single dataset.
*/

data _null_; 
     set &files; 
     call symput('url' || trim(left(_N_)), trim(left(url))); 
     call symput('dslabel' || trim(left(_N_)), trim(left(label))); 
     call symput('nobs', trim(left(_N_))); 
run;

%do i = 1 %to &nobs; 

filename resp temp;

proc http
 url="&&url&i"
 method="GET"
 out = resp;
run;

libname items json fileref=resp;

data &&dslabel&i;
 set items.root;
 drop ordinal_root usmart_id;
format report_date monyy7. totalAdults maleAdults adults18_24 adults25_44 adults45_64 adults65 numPrivateEmergency numSupportedTemp numTempEmergency numOther numFamilies numAdultsInFamilies numSingleParent numDependentFam comma10.;
keep Region report_date totalAdults maleAdults femaleAdults adults18_24 adults25_44 adults45_64 adults65 numPrivateEmergency numSupportedTemp numTempEmergency numOther numFamilies numAdultsInFamilies numSingleParent numDependentFam;
if vtype(Total_Adults) ='C' then totalAdults = input(Total_Adults,comma10.); else totalAdults = Total_Adults;
if vtype(Male_Adults) ='C' then maleAdults = input(Male_Adults,comma10.); else maleAdults = Male_Adults;
if vtype(Female_Adults) ='C' then femaleAdults = input(Female_Adults,comma10.); else femaleAdults = Female_Adults;
if vtype(Adults_Aged_18_24) ='C' then adults18_24 = input(Adults_Aged_18_24,comma10.); else adults18_24 = Adults_Aged_18_24;
if vtype(Adults_Aged_25_44) ='C' then adults25_44 = input(Adults_Aged_25_44,comma10.); else adults25_44 = Adults_Aged_25_44;
if vtype(Adults_Aged_45_64) ='C' then adults45_64 = input(Adults_Aged_45_64,comma10.); else adults45_64 = Adults_Aged_45_64;
if vtype(Adults_Aged_65_) ='C' then adults65 = input(Adults_Aged_65_,comma10.); else adults65 = Adults_Aged_65_;
if vtype(Number_of_people_who_accessed_Pr) ='C' then numPrivateEmergency = input(Number_of_people_who_accessed_Pr,comma10.); else numPrivateEmergency = Number_of_people_who_accessed_Pr;
if vtype(Number_of_people_who_accessed_Su) ='C' then numSupportedTemp = input(Number_of_people_who_accessed_Su,comma10.); else numSupportedTemp = Number_of_people_who_accessed_Su;
if vtype(Number_of_people_who_accessed_Te) ='C' then numTempEmergency = input(Number_of_people_who_accessed_Te,comma10.); else numTempEmergency = Number_of_people_who_accessed_Te;
if vtype(Number_of_people_who_accessed_Ot) ='C' then numOther = input(Number_of_people_who_accessed_Ot,comma10.); else numOther = Number_of_people_who_accessed_Ot;
if vtype(Number_of_Families) ='C' then numFamilies = input(Number_of_Families,comma10.); else numFamilies = Number_of_Families;
if vtype(Number_of_Adults_in_Families) ='C' then numAdultsInFamilies = input(Number_of_Adults_in_Families,comma10.); else numAdultsInFamilies = Number_of_Adults_in_Families;
if vtype(Number_of_Single_Parent_families) ='C' then numSingleParent = input(Number_of_Single_Parent_families,comma10.); else numSingleParent = Number_of_Single_Parent_families;
if vtype(Number_of_Dependants_in_Families) ='C' then numDependentFam = input(Number_of_Dependants_in_Families,comma10.); else numDependentFam = Number_of_Dependants_in_Families;
report_date=input(trim(scan("&&dslabel&i",2,"_")),monyy7.);
run;

libname items clear;
%end;

%mend;
