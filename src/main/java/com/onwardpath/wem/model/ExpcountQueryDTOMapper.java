package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ExpcountQueryDTOMapper implements RowMapper<ExpViewCountDTO> {

	@Override
	public ExpViewCountDTO mapRow(ResultSet rs, int rowNum) throws SQLException {

		ExpViewCountDTO dto = new ExpViewCountDTO();
		
		 
		dto.setRowCount(rs.getInt(1));
		return dto;
	}

}
