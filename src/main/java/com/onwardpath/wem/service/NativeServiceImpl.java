package com.onwardpath.wem.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.model.ExperienceViewPostDTO;
import com.onwardpath.wem.repository.NativeRepository;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowCountCallbackHandler;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

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

@Service
public class NativeServiceImpl implements NativeService {
	
	@Autowired
	NativeRepository nativeRepository;

	@Autowired
	private NamedParameterJdbcTemplate jdbcTemplate;
	
	// Custom Query for Experience View Page GET Request
	public String getResultSetforExpView(int id, int offset, int limit, String search) {
		MapSqlParameterSource parameters = new MapSqlParameterSource();
		System.out.println("id=" + id);
		parameters.addValue("org_id", id);
		parameters.addValue("offset", offset);
		parameters.addValue("limit", limit);
		JSONObject cnt_obj = new JSONObject();
		JSONObject Exp_obj = new JSONObject();
		JSONArray jarray = new JSONArray();
		String[] segment_names;
		String segments = "";
		String sql = null;
		String searchs = search;
		if(searchs != null)
		{
			System.out.println("search cmoing");
			parameters.addValue("search", "%"+ searchs + "%");
			sql = NativeRepository.expSearchSQL;
		}
		else
		{
			System.out.println("search not cmoing");
		 sql = NativeRepository.experienceviewSQL;
		}
		List<NativeQueryDTO> nativeQueryDTO = jdbcTemplate.query(sql, parameters, new NativeQueryDTOMapper());
		System.out.println("native result=" + nativeQueryDTO);
		for (NativeQueryDTO e : nativeQueryDTO) {

			parameters.addValue("exp_id", e.getId());
			String sqls = NativeRepository.expviewURLSQL;
			List<ExpURLDTO> nativeQueryDTOs = jdbcTemplate.query(sqls, parameters, new ExpURLQueryDTOMapper());
			String sql_count = NativeRepository.expRowCountSQL;

			RowCountCallbackHandler countCallback = new RowCountCallbackHandler();
			parameters.addValue("org_id", id);// not reusable
			jdbcTemplate.query(sql_count, parameters, countCallback);
			int rowCount = countCallback.getRowCount();
			Exp_obj.put("ExpCount", rowCount);
			for (ExpURLDTO u : nativeQueryDTOs) {

				cnt_obj.put("url", u.getUrl());
				cnt_obj.put("pages", u.getPageurl_count());

			}

			if (e.getSegmentname().contains(",")) {
				segment_names = e.getSegmentname().split(",");

				for (int i = 0; i < segment_names.length; i++) {
					segments += segment_names[i] + ",";

				}

			}

			else

				segments = e.getSegmentname() + ",";
			Exp_obj.put("experience", e.getExperience());
			Exp_obj.put("id", e.getId());
			Exp_obj.put("name", e.getName());
			Exp_obj.put("org_id", id);
			Exp_obj.put("segments", segments);
			Exp_obj.put("status", e.getStatus());
			Exp_obj.put("type", e.getType());

			JSONObject mergedJSON = mergeJSONObjects(cnt_obj, Exp_obj);
			jarray.put(mergedJSON);

		}

		System.out.println("json array=" + jarray.toString());

		return jarray.toString();
	}

	
	  public static JSONObject mergeJSONObjects(JSONObject json1, JSONObject json2)
	  { 
		  JSONObject mergedJSON = new JSONObject(); 
		  try { 
			  mergedJSON = new
			JSONObject(json1, JSONObject.getNames(json1)); 
			  for (String jsonKey : JSONObject.getNames(json2)) 
			  { 
				  mergedJSON.put(jsonKey, json2.get(jsonKey)); 
				  }
	  
	  } catch (JSONException e) 
		  { 
		  throw new RuntimeException("JSON Exception" + e);
	  } return mergedJSON; 
	  }
	 
	
	// Custom Query for Experience View Page POST Request
		public String getResultSetforExpViewPost(ExperienceViewPostDTO experienceViewPostDTO)
		{
			MapSqlParameterSource parameters = new MapSqlParameterSource();
			JSONObject Exp_obj = new JSONObject();
			JSONArray jarray = new JSONArray();
			String expvalues = "";
		//	String experience = experienceViewPostDTO.getExper();
			if ((experienceViewPostDTO.getExper().equals("content")) || (experienceViewPostDTO.getExper().equals("bar")) || (experienceViewPostDTO.getExper().equals("popup")) || (experienceViewPostDTO.getExper().equals("link")))
			{
				if ((experienceViewPostDTO.getService() != 0) && (experienceViewPostDTO.getExpid() != 0)) 
				{
					String sql = NativeRepository.contentExpSQL;
					parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
					parameters.addValue("seg_id", experienceViewPostDTO.getService());
					List<ExperienceContentDTO> expCountQueryDTO = jdbcTemplate.query(sql, parameters, new ExperienceContentDTOMapper());
					for (ExperienceContentDTO e : expCountQueryDTO) {
						System.out.println("content="+e.getContent());
						Exp_obj.put("content",e.getContent());
						jarray.put(Exp_obj);
						expvalues = jarray.toString();
					}
				}
			}
			
			else if(experienceViewPostDTO.getExper().equals("image"))
			{
				if ((experienceViewPostDTO.getService() != 0) && (experienceViewPostDTO.getExpid() != 0)) 
				{
					String sql = NativeRepository.imageExpSQL;
					parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
					parameters.addValue("seg_id", experienceViewPostDTO.getService());
					List<ExperienceContentDTO> expCountQueryDTO = jdbcTemplate.query(sql, parameters, new ExperienceContentDTOMapper());
					for (ExperienceContentDTO e : expCountQueryDTO) {
						System.out.println("content="+e.getContent());
						Exp_obj.put("content",e.getContent());
						jarray.put(Exp_obj);
						expvalues = jarray.toString();
					}
				}
			}
			
			else if(experienceViewPostDTO.getExper().equals("redirect"))
			{
				if ((experienceViewPostDTO.getService() != 0) && (experienceViewPostDTO.getExpid() != 0)) 
				{
					String sql = NativeRepository.redirectExpSQL;
					parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
					parameters.addValue("seg_id", experienceViewPostDTO.getService());
					List<ExperienceContentDTO> expCountQueryDTO = jdbcTemplate.query(sql, parameters, new ExperienceContentDTOMapper());
					for (ExperienceContentDTO e : expCountQueryDTO) {
						System.out.println("content="+e.getContent());
						Exp_obj.put("content",e.getContent());
						jarray.put(Exp_obj);
						expvalues = jarray.toString();
					}
				}
			}
			
			else if(experienceViewPostDTO.getExper().equals("style"))
			{
				if ((experienceViewPostDTO.getService() != 0) && (experienceViewPostDTO.getExpid() != 0)) 
				{
					String sql = NativeRepository.styleExpSQL;
					parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
					parameters.addValue("seg_id", experienceViewPostDTO.getService());
					List<ExperienceContentDTO> expCountQueryDTO = jdbcTemplate.query(sql, parameters, new ExperienceContentDTOMapper());
					for (ExperienceContentDTO e : expCountQueryDTO) {
						System.out.println("content="+e.getContent());
						Exp_obj.put("content",e.getContent());
						jarray.put(Exp_obj);
						expvalues = jarray.toString();
					}
				}
			}
			
			else if(experienceViewPostDTO.getExper().equals("block"))
			{
				if ((experienceViewPostDTO.getService() != 0) && (experienceViewPostDTO.getExpid() != 0)) 
				{
					String sql = NativeRepository.blockExpSQL;
					parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
					parameters.addValue("seg_id", experienceViewPostDTO.getService());
					List<ExperienceContentDTO> expCountQueryDTO = jdbcTemplate.query(sql, parameters, new ExperienceContentDTOMapper());
					for (ExperienceContentDTO e : expCountQueryDTO) {
						System.out.println("content="+e.getContent());
						Exp_obj.put("content",e.getContent());
						jarray.put(Exp_obj);
						expvalues = jarray.toString();
					}
				}
			}
			
			else if(experienceViewPostDTO.getExper().equals("status"))
			{
				if (experienceViewPostDTO.getToggle().equals("true")) {
				 String SQL = NativeRepository.updateExpStatusSQL;
				 parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
				 parameters.addValue("status", "on");
				 jdbcTemplate.update(SQL, parameters);
			      System.out.println("Updated Record with ID = " + experienceViewPostDTO.getExpid() );
				}
				else if (experienceViewPostDTO.getToggle().equals("false")) {
					
					 String SQL = NativeRepository.updateExpStatusSQL;
					 parameters.addValue("exp_id", experienceViewPostDTO.getExpid());
					 parameters.addValue("status", "off");
					 jdbcTemplate.update(SQL, parameters);
				     System.out.println("Updated Record with ID = " + experienceViewPostDTO.getExpid() );
				}
			}
			
			else if(experienceViewPostDTO.getExper().equals("search"))
			{
				int id = 1;
				int limit = 10;
				int offset = 0;
				System.out.println("seragh coming");
				String value = getResultSetforExpView(id,offset,limit,experienceViewPostDTO.getSearch());
				expvalues = value;
			}
			System.out.println("json content array=" + jarray.toString());
			return expvalues;
			
			
			
		}

		// Custom Query for Autocomplete AJAX GET Request
		public String SuggestionListValues(String startsWith, String filterBy) throws JsonGenerationException, JsonMappingException, IOException
		{
			MapSqlParameterSource parameters = new MapSqlParameterSource();
			String sql = "";
			String concatValues = null;
			parameters.addValue("geovalues", startsWith + "%");
			final StringWriter sw = new StringWriter();
			final ObjectMapper mapper = new ObjectMapper();
			ArrayList<String> citieslist = new ArrayList<String>();
			ArrayList<String> parentcitieslist = new ArrayList<String>();
			String LOVCityValues = NativeRepository.citySuggSQL;
			String LOVStatesValues = NativeRepository.stateSuggSQL;;
			String LOVCountryValues = NativeRepository.countrySuggSQL;
			
			if (filterBy.equals("country"))
			{
				sql = LOVCountryValues;
				List<SuggeslistDTO> suggeslistDTODTO = jdbcTemplate.query(sql, parameters, new SuggeslistDTOMapper());
				for (SuggeslistDTO s : suggeslistDTODTO) {
					
					System.out.println("code"+s.getCode());
					System.out.println("name"+s.getName());
					concatValues =  s.getCode() + ", " + s.getName();
					citieslist.add(concatValues);
				}
			}
			else if(filterBy.equals("state"))
			{
				sql = LOVStatesValues;
				List<SuggeslistDTO> suggeslistDTODTO = jdbcTemplate.query(sql, parameters, new SuggeslistDTOMapper());
				for (SuggeslistDTO s : suggeslistDTODTO) {
					
					System.out.println("code"+s.getCode());
					System.out.println("name"+s.getName());
					concatValues =  s.getName() + ", " + s.getCode();
					citieslist.add(concatValues);
				}
			}
			else if(filterBy.equals("city"))
			{
				sql = LOVCityValues;
				 List<SuggeslistDTO> suggeslistDTODTO = jdbcTemplate.query(sql, parameters, new SuggeslistCityDTOMapper()); 
				  for (SuggeslistDTO s : suggeslistDTODTO) {
				  
				  System.out.println("code"+s.getCode());
				  System.out.println("name"+s.getName()); 
				  concatValues = s.getCname() + ", " + s.getName()+ ", " + s.getCode(); 
				  citieslist.add(concatValues);
				  System.out.println("citylist="+citieslist);
				  }
			}
			
			 
			 
			parentcitieslist.addAll(citieslist);
			System.out.println("arraylist="+parentcitieslist.toString());
			mapper.writeValue(sw, parentcitieslist);
			System.out.println(sw.toString());
			return sw.toString();
			
			
		}

}
