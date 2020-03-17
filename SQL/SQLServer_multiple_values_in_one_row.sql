SELECT p.projectID, p.clientid, p.projectname, 
  STRING_AGG(i.name,', ') AS ind -- this one will show multiple names in one field
FROM projects as p
	LEFT OUTER JOIN projecttoindustry AS p2i
	ON p.projectID = p2i.projectID
		LEFT OUTER JOIN industries AS i
		ON p2i.industryID = i.id
WHERE p.clientid = 5
GROUP BY p.projectID, p.clientid, p.projectname
