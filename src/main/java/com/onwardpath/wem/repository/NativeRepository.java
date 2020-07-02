package com.onwardpath.wem.repository;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowCountCallbackHandler;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.model.ExpURLDTO;
import com.onwardpath.wem.model.ExpURLQueryDTOMapper;
import com.onwardpath.wem.model.ExpViewCountDTO;
import com.onwardpath.wem.model.ExpcountQueryDTOMapper;
import com.onwardpath.wem.model.ExperienceContentDTO;
import com.onwardpath.wem.model.ExperienceContentDTOMapper;
import com.onwardpath.wem.model.ExperienceViewPostDTO;
import com.onwardpath.wem.model.NativeQueryDTO;
import com.onwardpath.wem.model.NativeQueryDTOMapper;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.model.SuggeslistCityDTOMapper;
import com.onwardpath.wem.model.SuggeslistDTO;
import com.onwardpath.wem.model.SuggeslistDTOMapper;

@Component
public class NativeRepository {

	public static final String experienceviewSQL = "SELECT  * FROM  (select  experience.id as id, experience.name as experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, content where   experience.id = content.experience_id   and content.segment_id = segment.id   and user.org_id = :org_id and experience.org_id = :org_id  GROUP BY   experience.id union all\r\n"
			+ "select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, image where   experience.id = image.experience_id   and image.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id union all\r\n"
			+ "select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, redirect where   experience.id = redirect.experience_id   and redirect.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id union all\r\n"
			+ " select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, block where   experience.id = block.experience_id   and block.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id  union all\r\n"
			+ " select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, style where   experience.id = style.experience_id   and style.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id )experience\r\n"
			+ "GROUP BY experience.id ORDER BY experience.create_time 	DESC limit :offset,:limit";

	public static final String expviewURLSQL = "select Group_concat(DISTINCT config.url) AS url,count(*) as pageurl_count from config where experience_id = :exp_id";

	public static final String expSearchSQL = "SELECT  * FROM  (select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, content where   experience.id = content.experience_id   and content.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id and (experience.name  LIKE :search or segment.name LIKE :search) GROUP BY   experience.id union all  \r\n" + 
				"				select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, image where   experience.id = image.experience_id   and image.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id and (experience.name  LIKE :search or segment.name LIKE :search)  GROUP BY   experience.id union all \r\n" + 
				"				select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, redirect where   experience.id = redirect.experience_id   and redirect.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  and (experience.name  LIKE :search or segment.name LIKE :search) GROUP BY   experience.id union all \r\n" + 
                "				select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, block where   experience.id = block.experience_id   and block.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  and (experience.name  LIKE :search or segment.name LIKE :search) GROUP BY   experience.id union all \r\n" + 
                "				select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, style where   experience.id = style.experience_id   and style.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  and (experience.name  LIKE :search or segment.name LIKE :search)  GROUP BY   experience.id ) experience \r\n" + 
                "				GROUP BY experience.id  limit :limit ";
	
	public static final String expRowCountSQL = "select * FROM (select  experience.id as id, experience.name as experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, content where   experience.id = content.experience_id   and content.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id GROUP BY   experience.id union all\r\n"
			+ "select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, image where   experience.id = image.experience_id   and image.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id union all\r\n"
			+ "select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, redirect where   experience.id = redirect.experience_id   and redirect.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id union all\r\n"
			+ " select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, block where   experience.id = block.experience_id   and block.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id  GROUP BY   experience.id  union all\r\n"
			+ " select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, style where   experience.id = style.experience_id   and style.segment_id = segment.id   and user.org_id = :org_id  and experience.org_id = :org_id GROUP BY   experience.id )experience\r\n"
			+ "GROUP BY experience.id ORDER BY experience.create_time DESC";
	
	public static final String contentExpSQL = "select content from content where content.experience_id = :exp_id and content.segment_id = :seg_id";
	
	public static final String imageExpSQL = "select url from image where image.experience_id = :exp_id and image.segment_id= :seg_id";
	
	public static final String redirectExpSQL = "select redirect_url from redirect where redirect.experience_id = :exp_id and redirect.segment_id= :seg_id";
	
	public static final String styleExpSQL = "select  csslink from style where style.experience_id = :exp_id and style.segment_id= :seg_id";
	
	public static final String blockExpSQL = "select  block_url from block where block.experience_id = :exp_id and block.segment_id= :seg_id";
	
	public static final String updateExpStatusSQL = "update experience set status = :status where id = :exp_id";
	
	public static final String citySuggSQL = "select city.name as cname,state.name,country.code from city  join state join country on city.state_id = state.id where state.country_id = country.id AND city.name like :geovalues  ORDER BY city.name,state.name ASC LIMIT 10";
	
	public static final String stateSuggSQL = "select st.name,ctry.code from state st,country ctry where st.name like :geovalues and st.country_id = ctry.id";
	
	public static final String countrySuggSQL = "select code,name from country where name like :geovalues";
}