package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ExperienceContentDTOMapper implements RowMapper<ExperienceContentDTO> {

	@Override
	public ExperienceContentDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ExperienceContentDTO dto = new ExperienceContentDTO();
		
		 
		dto.setContent(rs.getString(1));
		return dto;
	}

}
