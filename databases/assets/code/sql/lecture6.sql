SELECT *
FROM Rooms R
LEFT JOIN Roomaccess Ra ON Ra.Room_id = R.Id
WHERE Ra.Role = (
    SELECT Role FROM People P
    WHERE P.Name = 'John Smith'
);
