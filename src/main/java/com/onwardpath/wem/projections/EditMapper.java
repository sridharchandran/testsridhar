package com.onwardpath.wem.projections;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.onwardpath.wem.model.ExperienceEditContentDTO;

public class EditMapper implements RowMapper<ExperienceEditContentDTO> {

	@Override
	public ExperienceEditContentDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
		ExperienceEditContentDTO editcontent = new ExperienceEditContentDTO();
		editcontent.setId(rs.getInt("id"));
		editcontent.setSegmentName(rs.getString("segmentname"));
		editcontent.setExperienceName(rs.getString("experience_name"));
		editcontent.setContent(rs.getString("content"));
		//editcontent.setPageurl(rs.getString("name")pageurl);
		
		return editcontent;
	}

}
