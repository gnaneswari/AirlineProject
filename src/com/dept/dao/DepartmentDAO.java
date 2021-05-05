package com.dept.dao;

import java.util.List;


import com.dept.DepartmentAlreadyExistException;
import com.dept.DepartmentNotFoundException;

//POJO interface to expose CRUD methods
public interface DepartmentDAO {
	void addDepartment(Department dRef) throws DepartmentAlreadyExistException ;		//	C - add - insert
	Department findDepartment(int dno);			//  R - find - select
	List<Department> findDepartments();			//  R - find - select all
	void modifyDepartment(Department dRef) throws DepartmentNotFoundException;		//  U - modify - update
	void removeDepartment(Department dRef) throws DepartmentNotFoundException;  
}
