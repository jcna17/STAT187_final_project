library(tidyverse)

#read in data
raw_data <- read_csv("covid_behavior.csv")
data <- raw_data[-1,]

#select columns of interest
data <- data %>%
  select("RecordNo" : "#times wash/sani", "gender" : "employment_status")

#rename columns
new_names <- c("RecordNo", "endtime", 
               "state", "qweek", 
               "hh_contact", "non_hh_contact",
               "n_leave_home", "tested", 
               "hh_tested", "cough", 
               "fever", "lost_smell",
               "lost_taste", "short_of_breath", 
               "no_symp", "contact_symp_person",
               "isolate_after_symp", "doctor_after_symp", 
               "travel_before_symp", "isolate_if_symp", 
               "isolation_ease", "isolation_willingness", 
               "mask", "hand_washing", 
               "sanitizer", "cover_mouth", 
               "avoid_symp_person", "avoid_going_out", 
               "avoid_healthcare", "avoid_pub_transport",
               "avoid_work_not_home", "avoid_school_not_home", 
               "avoid_guests", "avoid_s_gath", 
               "avoid_m_gath", "avoid_l_gath", 
               "avoid_crowds", "avoid_shopping", 
               "stop_share_bedroom", "stop_share_meals",
               "surface_cleaning", "avoid_touching_public_objects", 
               "n_wash_sanitize", "gender", 
               "age", "hh_size",
               "hh_children", "emp_status"
               )

names(data) <- new_names

#convert columns from character to form that can be used in ML models
summary(data)

#convert from character to integer
yn_levels <- c("No", "Yes")

data_recode <- data %>%
  #convert from character to numeric
  mutate(RecordNo = as.numeric(RecordNo),
         hh_contact = as.numeric(hh_contact),
         non_hh_contact = as.numeric(non_hh_contact),
         n_leave_home = as.numeric(n_leave_home),
         age = as.numeric(age),
         hh_size = as.numeric(hh_size),
         hh_children = as.numeric(hh_children),
         n_wash_sanitize = as.numeric(n_wash_sanitize)
         ) %>%
  #convert from yes/no character to factor
  mutate(cough = factor(cough, levels = yn_levels),
         fever = factor(fever, levels = yn_levels),
         lost_smell = factor(lost_smell, levels = yn_levels),
         lost_taste = factor(lost_taste, levels = yn_levels),
         short_of_breath = factor(short_of_breath, levels = yn_levels),
         no_symp = factor(no_symp, levels = yn_levels)
         )

summary(data_recode)
unique(data$sanitizer)




