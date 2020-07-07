package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ExpURLQueryDTOMapper implements RowMapper<ExpURLDTO> {

	@Override
	public ExpURLDTO mapRow(ResultSet rs, int rowNum) throws SQLException {

		ExpURLDTO dto = new ExpURLDTO();
		
		dto.setUrl(rs.getString(1));
		dto.setPageurl_count(rs.getInt(2));
		
		return dto;
	}
	

}
