head(a_e_data)
install.packages("rmarkdown")
library(rmarkdown)

hist(a_e_data$age.1.to.4)
qqnorm(a_e_data$age.0)
qqline(a_e_data$age.0)

shapiro.test(a_e_data$Total.emergency.workforce)

install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

a_e_data_long_age <- a_e_data %>%
  pivot_longer(cols = c(starts_with("age"), "UnknownAge"),  
               names_to = "Age_Group",    
               values_to = "Attendance") %>%
  select(year, Age_Group, Attendance)

a_e_data_long_ethnicity <- a_e_data %>%
  pivot_longer(cols = c(`African..Black.or.Black.British.`, 
                        `Bangladeshi..Asian.or.Asian.British.`, 
                        `Caribbean..Black.or.Black.British.`, 
                        `Any.other.Asian.background`, 
                        `Any.other.Black.background`,
                        `Any.other.ethnic.group`,
                        `Any.other.mixed.background`,
                        `Any.other.White.background`,
                        `Chinese..other.ethnic.group.`,
                        `Indian..Asian.or.Asian.British.`,
                        `Not.stated`,
                        `Pakistani..Asian.or.Asian.British.`,
                        `White.and.Asian..Mixed.`,
                        `White.and.Black.African..Mixed.`,
                        `White.and.Black.Caribbean..Mixed.`,
                        `White.British..White.`,
                        `White.Irish..White.`,
                        `UnknownEthnicity`),
               names_to = "Ethnicity", 
               values_to = "Attendance") %>%
  select(year, Ethnicity, Attendance)

a_e_data_long_gender <- a_e_data %>%
  pivot_longer(cols = c(`Female`, 
                        `Indeterminate`, 
                        `Male`, 
                        `UnknownGender`),
               names_to = "Gender", 
               values_to = "Attendance") %>%
  select(year, Gender, Attendance)

a_e_data_long_deprivation_level <- a_e_data %>%
  pivot_longer(cols = c(`Least.deprived.10.`, 
                        `Less.deprived.10.20.`, 
                        `Less.deprived.20.30.`,
                        `Less.deprived.30.40.`,
                        `Less.deprived.40.50.`,
                        `More.deprived.40.50.`,
                        `More.deprived.30.40.`,
                        `More.deprived.20.30.`,
                        `More.deprived.10.20.`,
                        `Most.deprived.10.`,
                        `UnknownLocation`),
               names_to = "Deprivation_level", 
               values_to = "Attendance") %>%
  select(year, Deprivation_level, Attendance)

a_e_data_long_dept_type <- a_e_data %>%
  pivot_longer(cols = c(`Type.1.Consultant.led.A.E`, 
                        `Type.2.Single.specialty.A.E`, 
                        `Types.3...4.Minor.Injury.or.Walk.in.units`, 
                        `UnknownDepttype`),
               names_to = "Dept_type", 
               values_to = "Attendance") %>%
  select(year, Dept_type, Attendance)

a_e_data_long_waiting_time <- a_e_data %>%
  pivot_longer(cols = c(`Attendances.4.hours.or.less`, 
                        `Attendances.over.4.hours`),
               names_to = "waiting_time", 
               values_to = "Attendance") %>%
  select(year, waiting_time, Attendance)

a_e_data_long_bed_occupancy <- a_e_data %>%
  pivot_longer(cols = c(`Total.available.beds`, 
                        `Total.occupied.beds`),
               names_to = "Bed_occupancy", 
               values_to = "Count") %>%
  select(year, Bed_occupancy, Count)

a_e_data_long_workforce <- a_e_data %>%
  pivot_longer(cols = c(`Total.emergency.workforce`),
               names_to = "Total_workforce", 
               values_to = "Count") %>%
  select(year, Total_workforce, Count)

## kruskal wallis testing for all variables
kruskal.test(Attendance ~ year, data = a_e_data_long_age)
kruskal.test(Attendance ~ year, data = a_e_data_long_gender)
kruskal.test(Attendance ~ year, data = a_e_data_long_ethnicity)
kruskal.test(Attendance ~ year, data = a_e_data_long_deprivation_level)
kruskal.test(Attendance ~ year, data = a_e_data_long_dept_type)
kruskal.test(Attendance ~ year, data = a_e_data_long_waiting_time)
kruskal.test(Count ~ year, data = a_e_data_long_bed_occupancy)
kruskal.test(Count ~ year, data = a_e_data_long_workforce)

## descriptive stats (mean, std dev) grouped by year

library(dplyr)

stats_summary_age_year <- a_e_data_long_age %>%
  group_by(year) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_age_year)

stats_summary_gender_year <- a_e_data_long_gender %>%
  group_by(year) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_gender_year)

stats_summary_ethnicity_year <- a_e_data_long_ethnicity %>%
  group_by(year) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_ethnicity_year)

stats_summary_deplevel_year <- a_e_data_long_deprivation_level %>%
  group_by(year) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_deplevel_year)

stats_summary_depttype_year <- a_e_data_long_dept_type %>%
  group_by(year) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_depttype_year)

stats_summary_waitingtime_year <- a_e_data_long_waiting_time %>%
  group_by(year) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_waitingtime_year)

stats_summary_bedoccupancy_year <- a_e_data_long_bed_occupancy %>%
  group_by(year) %>% 
  summarize(
    mean_count = mean(Count, na.rm = TRUE),
    sd_count = sd(Count, na.rm = TRUE)
  )
print(stats_summary_bedoccupancy_year)

stats_summary_workforce_year <- a_e_data_long_workforce %>%
  group_by(year) %>% 
  summarize(
    mean_count = mean(Count, na.rm = TRUE),
    sd_count = sd(Count, na.rm = TRUE)
  )
print(stats_summary_workforce_year)


## descriptive stats (mean, std dev) grouped by category
stats_summary_age_group <- a_e_data_long_age %>%
  group_by(Age_Group) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_age_group)


stats_summary_gender <- a_e_data_long_gender %>%
  group_by(Gender) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_gender)


stats_summary_ethnicity <- a_e_data_long_ethnicity %>%
  group_by(Ethnicity) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_ethnicity)


stats_summary_deplevel <- a_e_data_long_deprivation_level %>%
  group_by(Deprivation_level) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_deplevel)

stats_summary_depttype <- a_e_data_long_dept_type %>%
  group_by(Dept_type) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_depttype)

stats_summary_waitingtime <- a_e_data_long_waiting_time %>%
  group_by(waiting_time) %>% 
  summarize(
    mean_attendance = mean(Attendance, na.rm = TRUE),
    sd_attendance = sd(Attendance, na.rm = TRUE)
  )
print(stats_summary_waitingtime)

stats_summary_bedoccupancy <- a_e_data_long_bed_occupancy %>%
  group_by(Bed_occupancy) %>% 
  summarize(
    mean_count = mean(Count, na.rm = TRUE),
    sd_count = sd(Count, na.rm = TRUE)
  )
print(stats_summary_bedoccupancy)

stats_summary_workforce <- a_e_data_long_workforce %>%
  group_by(Total_workforce) %>% 
  summarize(
    mean_count = mean(Count, na.rm = TRUE),
    sd_count = sd(Count, na.rm = TRUE)
  )
print(stats_summary_workforce)
