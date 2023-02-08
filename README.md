# Google Analytics Certificate Capstone project  

![alt text](/images/bicicle.jpg)

## Background  

The Google Analytics Certificate requires students to do a case study to test the skills learnt during the course. This capstone project allows students to practice in a "simulated real-world scenario". This case study investigates the hypothetical scenario of a company called "Cyclistic", which offers a bike-share service in Chicago, USA.  

### Scenario  

The company is planning on future actions. The marketing director believes that the company's future success depends on maximizing the number of clients on membership plans. There are two main types of clients: casual and members. This study investigated how casual and member clients differ when using the service. The results provide evidence for data-driven decisions on future marketing campaigns.  

**Key stakeholders**  

* Cyclistic - Bike-share company with more than 5800 bikes and 600 docking stations. The company offer classic, reclining, hand tricycles, and cargo bikes (these options make the service inclusive). Majority of the clients use classic bikes whereas about 8% opt for assistive options. Users are more likely to ride for leisure although about 30% use the service to commute to work daily.  

* Lily Moreno - Director of marketing and the character's manager. Moreno is responsible for the marketing initiatives.  

* Cyclistic marketing analytics team - A team of data analysts responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.  

* Cyclistic executive team - The team that make decisions about marketing program proposals.  

After a thorough assessment of the scenario and requirements, I set off the plan to perform the tasks. I followed all the steps and procedures taught in the data analytics course applying the best practices for data analysis. The backbone of the process follows the **ask**, **prepare**, **process**, **analyse**, **share**, and **act** scheme and is documented below.  

## Case Study Roadmap  

### **Ask**  

Three questions will guide the future marketing program and identify the business task:  

1. How do annual members and casual riders use Cyclistic bikes differently?  
2. Why would casual riders buy Cyclistic annual membership?  
3. How can Cyclistic use digital media to influence casual riders to become members?  

I was assigned to identify how casual clients differ from member clients. One of the company's hypotheses is that the member clients are the future of the company. Also, the insights that arise from the analysis may help turn casual clients into annual member clients to bring more revenue for the company.  

### **Prepare**  

A webpage stores the data used in this project in separate links (by month) in .zip folders. The data in .csv files, formatted as tables are available for download. The bike's GPS units seem to have collected the data. Assuming the data come from GPS units, the bias that may exist come from equipment error and may be systematic.  

Cyclistic's geo-tracking system may have collected this data while Motivate International Inc. made it available, under a specific license agreement. This agreement also prohibits using the client's personally identifiable information. The data was stored in a physical drive (external hard drive) protected by a password. After downloading, I have created a backup copy and stored the data. I have inspected the data visually and prepared it for sorting, filtering, and cleaning. Also, ensuring the data integrity would enhance the quality of the interpretation of the outcomes of the data analysis.  

### **Process**  

For this project, I will use R and RStudio software due to the size of the dataset and because I will have to provide high-quality visualization. After having inspected the files and applied data cleaning techniques to find any problem with the data, I have applied filters and sort commands to look for anomalies in the data. I have also used visualization to assess the data. All the documentation has been done using RMarkdown.  

### **Analyze**  

The data covers one year of service. Each file represents one month. I need to combine all the files into a single big file for analysis. This bigger file will allow me to look for differences between casual and member clients.  

#### Tools for analysis  

For this project, I am using R programming for data wrangling, analysis, and visualization. I have loaded each individual file and merged them into a single .csv file for pre-processing, cleaning, and feature engineering. The steps taken at this stage were:

* Load data (individual files);
* Merge files;
* Create back up;
* Inspect data structure and dimension;
* Deal with DATE format;
* Feature engineering;
* Summary statistics; (this step is particularly helpful since it guides the data cleaning)
* Data filtering;

#### Analysing the data  

* After a thorough data cleaning and filtering, the dataset contains 2540274 casual clientes and 3142679 member clients.

* Overall, casual clients rode for 68183113 minutes, whereas the member clients spent 42057158 minutes using the bikes.

* The table below provides a description riding statistics of the two types of clients:  

| Customer type | Min duration(min) | Max duration(min) | Median duration(min) | Mean duration +/- SD(min) |
| --- | --- | --- | --- | --- |
|Casual | 0.1 | 1439.9 | 15.9 | 26.8 +/- 47.8 |
|Member | 0.1 | 1439.9 | 9.6 | 13.4 +/- 20.8 |
|

* When data is detailed to customer type and day of the week level, they show that casual clients ride longer on average. See table below:

| Customer type | Weekday | Mean duration (min) |
| --- | --- | --- |
| Casual | Monday | 27.2 |
| Casual | Tuesday | 24.4 |
| Casual | Wednesday | 23.2 |
| Casual | Thursday | 23.1 |
| Casual | Friday | 24.9 |
| Casual | Saturday | 29.1 |
| Casual | Sunday | 31.0 |
| Member | Monday | 13.0 |
| Member | Tuesday | 12.6 |
| Member | Wednesday | 12.6 |
| Member | Thursday | 12.5 |
| Member | Friday | 13.1 |
| Member | Saturday | 14.9 |
| Member | Sunday | 15.3 |


### **Share**  

The **share** part of the report is important since it is here that you communicate your findings to the stakeholders (and anyone else interested on them).  

First, let's check some visualizations of the data.  

#### Data visualization  

**Total rides by weekday**  

![alt text](/images/fig1.png)

Figure 1. The data show that from Monday to Friday, the service is mostly used by members whereas casual clients use the service more than members on weekends.  

**Monthly usage by customer type**  

![alt text](/images/fig2.png)

figure 2. Casual clients only use the service more than member clients during June, July, and August. Since the days during this period are warmer, it is likely that casual clients use the service for leisure.  

**Average ride duration the customer type usage by day of the week**  

![alt text](/images/fig3.png)

Figure 3. Casual clients spend substantially more time in the rides compared to their member clients counterparts.  

**Average ride duration by customer type and month**  

![alt text](/images/fig4.png)

Figure 4. Casual clients use the service for longer duration over the year while the ride duration for member clients remain fairly constant.  


**Looking at the bike types rented**  

![alt text](/images/fig5.png)

Figure 5. The most used bikes are classic and electric, respectively for both casual and member clients.  



**Looking at the demand throughout the day**  

![alt text](/images/fig6.png)

Figure 6. The figure above suggests that member clients use the bikes to commute to work since peak usage coincide with the time people star and finish working whereas casual clients increase the use over the day and surpass members clients usage during weekends.  


![alt text](/images/fig7.png)

Figure 7. When assessing the demand throughout the day for every month of the year, the data show an interesting trend and an opportunity to explore.  



### **Act**  

**Conclusions**  

After a thorough analysis of the data and a clear questions to answer, I have come to the following conclusions:  

1.	Although there are more member clients, the casual clients use the service for longer duration;
2.	During weekdays, members use the service more than casual clients. On the weekends, casual clients use the service more than members (Figure 1);  
3.	The total number of rides remain fairly the same over the entire week for member clients while it remains the same during weekdays and peak on weekends for casual clients (Figure 1);  
4.	The number of rides for casual clients is larger in June, July, and August, compared to member clients. The usage of the service is larger during the months where the temperature is warmer (figure 2);  
5.	Casual clients’ rides are 50% longer than member client rides ( Figure 3 and Figure 4);  
6.	Casual clients choose as much classic bikes as electric ones, whereas members choose more classic bikes, compared to the other options (Figures 5 to 7).  

**Recommendations**  

* Promotions to make casual clients to become member clients;  

* Offer promotions before noon to increase the number of rides by casual clients during this time window;  

* Raise the price for single and full day fares on weekends encouraging casual clients to become member clients.  
