# Attendance Report Generator

### This Flutter application is developed to aid in taking the attendance of the students on your phone and generate the report as a text or image.

## Problem Indentification:
Being a Class Representative in a university, there is always a hectic routine to manage when it comes to the proper management of the class. Taking and managing the record of the attendance of whole class is tedious task. One the issues which led me to develop this app was remembering the roll number sequence of the class.

## Proposed Solution:
I was looking for a solution which can get me rid of remembering my duties all the time. The app is developed to help CRs in taking the attendance with ease. User is required to add each classmate individually or can import the list from MS Excel sheet (which comes in very handy).
User can then by generate a list of absentees or the present students either in plain text or in a graphical form and directly share it with the concerend teacher or the class for the verification.
This is just one of the many features wich are to be added in the app, including but not limited to, current class reminder, tests and assignments reminder and much more.

## Development Phase Challenges
- Selecting a database for scalibilty
- Proper state management solution selection.

## Flutter packages/plugins used:
- State management: `Provider`
## Database: `Hive`
 -  Lightweight and blazing fast key-value database written in pure Dart. Strongly encrypted using AES-256.
 -  For the flexibility in data, this database was needed as in the record, some of the students might be having different type of data.
 In the app, there can be studends from different departments having different patterns of roll numbers assigned to them, the flexibility in database schema was much needed. Since the Hive is written in pure dart, this was the feasible option to go for.
 
 ----------------------------------------------------------------------------
- For loading CSV files: `CSV`
- For copying text to the clipboard: `Clipboard`
- For taking screenshot of the report: `Screenshot`
- For date time Format: `Intl`
- For sharing: `Share`
- For getting paths: `Path Provider`
- For animations: `Lottie`
- For permission handling: `Permission Handler`

## Feel free to add your contribution!

### Screens
<br />

![attendance_app_mockup](https://user-images.githubusercontent.com/60597290/186166977-c05315d6-7421-4350-a7a0-010e4835fc58.png)

<br />

### Thank you for visiting this repo!
