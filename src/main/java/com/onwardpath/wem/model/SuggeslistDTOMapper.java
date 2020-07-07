package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class SuggeslistDTOMapper implements RowMapper<SuggeslistDTO> {

	@Override
	public SuggeslistDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		SuggeslistDTO dto = new SuggeslistDTO();
		dto.setCode(rs.getString("code"));
		dto.setName(rs.getString("name"));
		
		return dto;
	}

}
