package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class SuggeslistCityDTOMapper implements RowMapper<SuggeslistDTO> {

	@Override
	public SuggeslistDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		SuggeslistDTO dto = new SuggeslistDTO();
		
		dto.setCname(rs.getString(1));
		dto.setName(rs.getString(2));
		dto.setCode(rs.getString(3));
		
		return dto;
	}

}
