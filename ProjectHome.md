# Library Instruction Session Database #
For over 20 years, libraries have collected and reported the number of sessions and students served to ARL and other reporting agencies. While these particular metrics are useful for reporting to outside agencies, libraries struggle with determining the overall scope and frequency of instructional offerings to individual students, and reporting compliance, as often little effort is spent to encourage reporting by individuals. By tracking the session offerings and students served through the LISD, libraries develop an enhanced view the departments and faculty members who contribute to library instructional successes while providing opportunities to assess the gaps in current offerings.  Further, the LISD addresses the lack of incentive for individual reporting by providing individualized statistics for contributing librarians, allowing individuals a view of their individual contributions to instructional efforts.

Coded in python utilizing the Django framework, the **Library Instruction Session Database (LISD)** is an extensible tool designed to assist Academic Libraries in tracking instructional offerings and students served using a relational database. Real time results allow for easy review of instructional offerings across categories by date, type of instructional session, and individual contributions. Once populated with session information, the LISD can be populated with course rosters to assist in tracking:
  * Which students receive instruction, and the frequency thereof
  * The course that instruction was received
Data collected assists in informing:
  * The scope of instruction offered in a given time-frame:
    * Across the disciplines
    * Types of sessions
  * The frequency of instruction received by students:
    * Individually
    * In particular majors
    * When (1st year, 2nd year, etc.) in the educational process instruction is being received
  * Assists in identifying LI/IL campus champions and courses that traditionally receive instruction in order to further target efforts
  * The course instructor for the session
  * The librarian providing the instruction
The web-based nature of the LISD provides stratified permissions for entering and working with data.  As it is database independent, the LISD can be queried using any major database management software.
## Combining Student Data for Insight: ##
As provided, the LISD allows for recording only of identification numbers of students to minimize data privacy and security concerns.  When combined with other institutional data, information from the LISD assists in approaching questions about library value.  Once a library understands who it reaches with instructional offerings, when students receive instruction in their educational careers, and the frequency thereof, organizations can target offerings, and begin to formulate impact statements.  The following examples should illustrate how the LISD can inform the scope of instruction offered, and begin to approach the impact of multiple instructional offerings on individual students.
  * A simple recording of all sessions offered in a given timeframe when combined with course rosters from institutional data sources to quantify the scope of instruction for given populations (i.e. percentage of first year students that received library instruction).

  * A cohort of students who have received library instruction five times can be determined with the LISD. This information can be combined with other institutional data to determine their majors.  Once identified by major, subgroups can be selected and overall GPAs for students receiving instruction at least five times within a particular major can be compared to the overall average GPA for students in that major.
    * While this example does not purport that as a result of library instruction students in the major have higher GPAs, it does provide a direction for further exploration