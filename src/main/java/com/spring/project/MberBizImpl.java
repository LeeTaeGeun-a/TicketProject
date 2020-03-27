package com.spring.project;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("mbrBiz")
public class MberBizImpl implements MberBiz {
	@Autowired
	private JavaMailSenderImpl mailSender;
	@Autowired
	MberDAO 	mberDao;
	@Autowired
	MberQebc	mberQebc;
	@Autowired
	AdvantkQebc advQebc;
	@Autowired
	MberInqQebc inqQebc;
	@Autowired
	IntrstQebc 	intrstQebc;
	@Autowired
	PblprfrDAO 	pblDao;
	
	static final int LOGIN_SUCCESS  = 0;
	static final int LOGIN_FAIL_PW  = 1;
	static final int LOGIN_FAIL_ID	= 2;

	
	@Override
	public MberDTO bizSelectOne(String mberId) {
		
		MberDTO mberDto = mberDao.selectOne(mberId);
		
		return mberDto;
	}
	
	@Override
	public HashMap<String,Object> bizLogin(MberDTO mbrDto) 
	{
		int res = 0;
		HashMap<String,Object> mbrMap = new HashMap<String,Object>();
		MberDTO ckDto = mberDao.selectOne(mbrDto.getMberId());
		
		if(ckDto == null ||"N".equals(ckDto.getMberAt()))
		{
			res = LOGIN_FAIL_ID;
			mbrMap.put("loginRes", res);
			return mbrMap;
		}
		String getPw = mbrDto.getMberPw();
		String mbrPw = ckDto.getMberPw();
		if(!(getPw.equals(mbrPw)))
		{
			res = LOGIN_FAIL_PW;
			mbrMap.put("loginRes", res);
			return mbrMap;
		}

		
		res = LOGIN_SUCCESS;
		mbrMap.put("gMberData", ckDto);
		mbrMap.put("loginRes", res);
		
		return mbrMap;
	}

	@Override
	public int bizInsert(MberDTO dto) {
		int res = 0;
		MberDTO ckDto = mberDao.selectOne(dto.getMberId());
		
		if(ckDto != null)
		{
			return res;
		}
		
		// 이메일 처리
		String email = dto.getMberEmail();
		String eSite = dto.getEmSite();
		email = email +"@"+ eSite;
		dto.setMberEmail(email);
		dto.setMberAt("Y");
		dto.setMberLevel("1");
		
		mberDao.insert(dto);
		res=1;
		
		return res;
	}

	/*추가*/
	@Override
	public String bizIdFind(MberDTO dto) {
		String email = dto.getMberEmail();
		String eSite = dto.getEmSite();
		email = email +"@"+ eSite;
		dto.setMberEmail(email);
		
		MberDTO res = mberQebc.selectId(dto.getMberNm(),dto.getMberEmail());
		
		if(res == null)
		{
			return "fail";
		}
		String id = res.getMberId();
		int len = id.length();
		String result = id.substring(0,len-1);

		return result+"*";
	}
	@Transactional
	@Override
	public String bizPwfind(MberDTO dto) {
		MberDTO ckDto = mberDao.selectOne(dto.getMberId());

		final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
//		임시비밀번호 자릿수 =6
		int count = 6;
//		임시비밀번호 생성	
		StringBuilder builder = new StringBuilder();
		while (count-- != 0) {
			int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		String tmpPw =  builder.toString();
		ckDto.setMberPw(tmpPw);
//		임시비밀번호를 DB에 업데이트
		mberDao.update(ckDto);
//
		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"UTF-8"); // @formatter:off
				helper.setFrom("admin"); 
				helper.setTo(ckDto.getMberEmail()); 
				helper.setSubject("KG 티켓입니다.");
				helper.setText("임시비밀번호는 "+"<H2>"+tmpPw+"</H2>"+"입니다."
						+ "\n비밀번호를 반드시 변경해주세요.", true);
			}
		};
		 mailSender.send(preparator);
		
		return "success";
	}
	@Transactional
	@Override
	public MberDTO bizMberCrtfc(MberDTO dto) {
		MberDTO ckDto = mberDao.selectOne(dto.getMberId());

		
		String cEmail = ckDto.getMberEmail();
		String cNm =ckDto.getMberNm();
		
		String email = dto.getMberEmail();
		String eSite = dto.getEmSite();
		String emailAddr = email +"@"+ eSite;
		String nm = dto.getMberNm();

		
		if(!(nm.equals(cNm) && emailAddr.equals(cEmail)))
		{
			return ckDto;	
		}
		
		final String ALPHA_NUMERIC_STRING = "0123456789";
//		임시번호 자릿수 =6
		int count = 6;
//		임시번호 생성	
		StringBuilder builder = new StringBuilder();
		while (count-- != 0) {
			int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		String tmpNum =  builder.toString();
		ckDto.setMberCrtfc(tmpNum);

		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"UTF-8"); // @formatter:off
				helper.setFrom("admin"); 
				helper.setTo(emailAddr); 
				helper.setSubject("KG 티켓입니다.");
				helper.setText("인증번호는 "+"<H2>"+tmpNum+"</H2>"+"입니다.", true);
			}
		};
		 mailSender.send(preparator);
		return ckDto;
	}

	@Override
	public HashMap<String, Object> bizMyPage(String mberId) {
		int maxSize = 5; //가져올 로우수 
		HashMap<String, Object> hs;
		MberDTO tmp = mberDao.selectOne(mberId);
		if(tmp == null)
		{
			return null;
		}
		hs = new HashMap<String, Object>();
		hs.put("mberId",mberId);
		hs.put("startRow",1);
		hs.put("maxSize",maxSize);
		List<AdvantkJoinDTO> advList = advQebc.selectForUser(hs); 
		if(advList != null)
		{
			// 취소가능 날짜 처리 로직
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			Calendar calendar = Calendar.getInstance();
			List<String> cclPsDate = new ArrayList<String>();
			for(AdvantkJoinDTO joinDto : advList) 
			{
				String scrinngDt = joinDto.getScrinngDt();
				String scrDtArr[] = scrinngDt.split("/");
				String scrDate = scrDtArr[0];
				
				try{
					calendar.setTime(sdf.parse(scrDate));
					calendar.add(Calendar.DATE, -1); //하루빼기
					String canclePsdate = sdf.format(calendar.getTime());
					cclPsDate.add(canclePsdate);
				}catch(ParseException e) {
					e.printStackTrace();
				}
			}
			hs.put("cclPsDate", cclPsDate);
		}	
		
		System.out.println("-------------------------");
		System.out.println(hs.get("mberId"));
		System.out.println(hs.get("startRow"));
		
		List<MberInqDTO> inqList = inqQebc.selectForUser(hs); 
		
		System.out.println("-------------------------");
		System.out.println(hs.get("mberId"));
		System.out.println(hs.get("startRow"));
		
		List<IntrstJoinDTO> intrstList = intrstQebc.selectForUser(hs);


		hs.put("ADVANTK", advList);
		hs.put("MBERINQ", inqList);
		hs.put("INTRST", intrstList);
		
		return hs;
	}


	@Override
	public int bizUpdate(MberDTO dto) {
		int res = 0;
		MberDTO data = mberDao.selectOne(dto.getMberId());

		if("N".equals(dto.getMberAt()))
		{
			data.setMberAt("N");
			res = 2;
			mberDao.update(data);
			return 2;
		}
		
		if(!(dto.getMberPw().isEmpty()))
		{
			data.setMberPw(dto.getMberPw());
		}

		data.setMberTel(dto.getMberTel());
		data.setMberEmail(dto.getMberEmail()+"@"+dto.getEmSite());
		mberDao.update(data);
		res=1;
		return res;
	}

	@Override
	public int bizAtUpdate(String mberId) {
		int res = 0;
		MberDTO data = mberDao.selectOne(mberId);
		data.setMberAt("N");
		
		mberDao.update(data);
		res = 1;
		return res;
	}

	@Override
	public String bizPwConfirm(MberDTO dto) {
		String id = dto.getMberId();
		MberDTO chk = mberDao.selectOne(id);
		if((chk.getMberPw()).equals(dto.getMberPw()))
		{
			return "success";
		}

	
		return "fail";
		
	}

	@Override
	public MberDTO bizUpdateForm(String mberId) {
		MberDTO data = mberDao.selectOne(mberId);
		String email = data.getMberEmail();
		String[] array = email.split("@");
		
		data.setMberEmail(array[0]);
		if(array.length == 2)
		{
			data.setEmSite(array[1]);
		}
		return data;
	}

	@Override
	public List<MberDTO> bizSelectAll(String cmbValue, String input,int pageNum) {
		int max = 10;
		int start = ((pageNum-1)*max)+1;

		input = "%"+input+"%";
		List<MberDTO> list;
		
		if("name".equals(cmbValue))
		{
			list = mberQebc.selectNmAll(input, start, max);
			return list;
		}
		list = mberQebc.selectIdAll(input, start, max);
		return list;
	}

}
