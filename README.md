# Layoff-Project
Data Cleaning on Layoff Datasets using MySQL
Some of its data can't be used directly to create a dashboard and need some cleaning <br><br>
_Problems_ :<br>
1. Duplicated data <br>
2. Spaces in column <br>
3. Date is not in the right format <br>
4. Some null data <br>

_Datasets_<br>
Step 1 : Download datasets and convert it into SQL files <br>
Step 2 : Identify the data in the datasets<br><br>
_SQL processes_<br>
Step 1 : Remove duplicates<br>
  &emsp;First, Create identification to each row indicating unique values of each row<br>
  &emsp;Second, create new table to add row number to identify duplicates row<br>
  &emsp;Third, create CTE to sort out duplicates and delete all of the duplicates<br>
Step 2 : Standardize the data<br>
  &emsp;First, using "distinct" function to find unstandardized data<br>
  &emsp;Second, for name, location (strings) we can use trim for spaces<br>
  &emsp;Third, for date, we can "use str_to_date" function to change the format and use "alter" function to change the date type<br>
Step 3 : Manage null and blank values<br>
  &emsp;First, select the data that have null (in this case industry, total_laid_off and percentage_laid_off)<br>
  &emsp;Second, for industry, we can populate the null data as the other company has the data by using "join" function<br>
  &emsp;Third, for total_laid_off and percentage_laid_off, we can't populate it as the data lacking coresponding data. It will be continued in step 4<br>
Step 4 : Remove unnecessary column<br>
  &emsp;First, as total_laid_off and percentage_laid_off can't be populated, we need to remove it when BOTH of it is null<br>
  &emsp;Second, remove identification row as it is not needed anymore<br>
<br>
Thanks for reading
