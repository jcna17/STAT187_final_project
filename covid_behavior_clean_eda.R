library(tidyverse)

#read in data
raw_data <- read_csv("covid_behavior.csv")
data <- raw_data[-1,]

#select columns of interest
data <- data %>%
  select("endtime" : "#times wash/sani", "gender" : "employment_status")

#rename columns
new_names <- c("endtime", 
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

#data summary before recoding
summary(data)

#commonly used factor levels
yn_levels <- c("No", "Yes")
freq_levels <- c("Not at all", "Rarely", "Sometimes", "Frequently", "Always")

data_recode <- data %>%
  #convert from character to numeric
  mutate(hh_contact = as.numeric(hh_contact),
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
         ) %>%
  #convert from frequency character to factor
  mutate(mask = factor(mask, levels = freq_levels),
         hand_washing = factor(hand_washing, levels = freq_levels),
         sanitizer = factor(sanitizer, levels = freq_levels),
         cover_mouth = factor(cover_mouth, levels = freq_levels),
         avoid_symp_person = factor(avoid_symp_person, levels = freq_levels),
         avoid_going_out = factor(avoid_going_out, levels = freq_levels),
         avoid_healthcare = factor(avoid_healthcare, levels = freq_levels),
         avoid_pub_transport = factor(avoid_pub_transport, levels = freq_levels),
         avoid_work_not_home = factor(avoid_work_not_home, levels = freq_levels),
         avoid_school_not_home = factor(avoid_school_not_home, levels = freq_levels),
         avoid_guests = factor(avoid_guests, levels = freq_levels),
         avoid_s_gath = factor(avoid_s_gath, levels = freq_levels),
         avoid_m_gath = factor(avoid_m_gath, levels = freq_levels),
         avoid_l_gath = factor(avoid_l_gath, levels = freq_levels),
         avoid_crowds = factor(avoid_crowds, levels = freq_levels),
         avoid_shopping = factor(avoid_shopping, levels = freq_levels),
         stop_share_bedroom = factor(stop_share_bedroom, levels = freq_levels),
         stop_share_meals = factor(stop_share_meals, levels = freq_levels),
         surface_cleaning = factor(surface_cleaning, levels = freq_levels),
         avoid_touching_public_objects = factor(avoid_touching_public_objects, levels = freq_levels)
         ) %>%
  #convert other characters to factor
  mutate(tested = factor(tested, levels = c("No, I have not", "Yes, and I tested positive",
                                            "Yes, and I have not received my results from the test yet",                                                 "Yes, and I tested negative"),
                                 labels = c("N", "Y+", "Y~", "Y-")))

summary(data_recode)

unique(data$tested)
unique(data$hh_tested)




