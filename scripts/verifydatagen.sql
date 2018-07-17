select count(*) CONCAT ' Actions Created ---Expected Actions: 200' AS Actions from outcomeplanactionadmin
select count(*) CONCAT ' Goals Created ---Expected Goals: 100' AS Goals from expectedoutcome
select count(*) CONCAT ' Services Created ---Expected Services: 60' AS Services from serviceoffering
select count(*) CONCAT ' Programs Created ---Expected Programs: 10' AS Programs from outcomeplanadmin
select count(*) CONCAT ' Assessments Created ---Expected Assessments: 100' AS Assessments from assessmentdefinition where assessmenttype = 'AST10001'
select count(*) CONCAT ' Questionnaires Created ---Expected Questionnaires: 100' AS Questionnaires from assessmentdefinition where assessmenttype = 'AST10002'
select count(*) CONCAT ' Skills Created ---Expected Skills: 5' AS Skills from skill
select count(*) CONCAT ' Roles Created ---Expected Roles: 4' AS Roles from careteamrole
select count(*) CONCAT ' Users Created ---Expected Users: 460' AS Users from users
select count(*) CONCAT ' Clients Created ---Expected Clients: 14400' AS TotalClients from concernrole
select count(*) CONCAT ' Barriers Created ---Expected Barriers: 7' AS Barriers from barrieradmin
select count(*) CONCAT ' Alerts Created ---Expected Alerts: 6' AS Alerts from alertadmin where preconfiguredind = 0
select count(*) CONCAT ' OrgUnits Created ---Expected OrgUnits: 10' AS OrgUnits from orgunit
select count(providerid) CONCAT ' Providers Created ---Expected Providers: 800' AS Providers from provider
select count(*) CONCAT ' Failed GeoCodes ---Expected Failures: 0' AS FailedGeocodeAddressData from address where addressdata LIKE '%GEOCODE=0.0,0.0:0%'
select count(*) CONCAT ' Failed GeoCodes ---Expected Failures: 0' AS FailedGeocodeLatLong from address where latitude = '+0.00000000000000E+000'
echo Number of Clients Per Care Manager
SELECT count(concernrole.concernrolename) AS ClientNumber, substr(users.fullname, 1, 70) AS CareManager, substr(codetableitemdescription.description, 1, 20) As Role FROM concernrole INNER JOIN careteam ON concernrole.concernroleid = careteam.concernroleid INNER JOIN careteammember ON careteammember.careteamid = careteam.careteamid INNER JOIN users ON users.username = careteammember.username INNER JOIN careteammemberrole ON careteammember.careteammemberid = careteammemberrole.careteammemberid INNER JOIN careteamrole ON careteammemberrole.careteamroleid = careteamrole.careteamroleid INNER JOIN codetableitemdescription ON careteamrole.careteamrolecode = codetableitemdescription.code where codetableitemdescription.description ='Care Manager' GROUP BY codetableitemdescription.description, users.fullname
echo Number of Clients Per Counsellor
SELECT count(concernrole.concernrolename) AS ClientNumber, substr(users.fullname, 1, 70) AS Counsellor, substr(codetableitemdescription.description, 1, 20) As Role FROM concernrole INNER JOIN careteam ON concernrole.concernroleid = careteam.concernroleid INNER JOIN careteammember ON careteammember.careteamid = careteam.careteamid INNER JOIN users ON users.username = careteammember.username INNER JOIN careteammemberrole ON careteammember.careteammemberid = careteammemberrole.careteammemberid INNER JOIN careteamrole ON careteammemberrole.careteamroleid = careteamrole.careteamroleid INNER JOIN codetableitemdescription ON careteamrole.careteamrolecode = codetableitemdescription.code where codetableitemdescription.description ='Counsellor' GROUP BY codetableitemdescription.description, users.fullname
echo Number of Clients Per Nutritionist
SELECT count(concernrole.concernrolename) AS ClientNumber, substr(users.fullname, 1, 70) AS Nutritionist, substr(codetableitemdescription.description, 1, 20) As Role FROM concernrole INNER JOIN careteam ON concernrole.concernroleid = careteam.concernroleid INNER JOIN careteammember ON careteammember.careteamid = careteam.careteamid INNER JOIN users ON users.username = careteammember.username INNER JOIN careteammemberrole ON careteammember.careteammemberid = careteammemberrole.careteammemberid INNER JOIN careteamrole ON careteammemberrole.careteamroleid = careteamrole.careteamroleid INNER JOIN codetableitemdescription ON careteamrole.careteamrolecode = codetableitemdescription.code where codetableitemdescription.description ='Nutritionist' GROUP BY codetableitemdescription.description, users.fullname
