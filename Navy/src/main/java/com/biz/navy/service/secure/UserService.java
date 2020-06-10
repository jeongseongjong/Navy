package com.biz.navy.service.secure;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.navy.dao.AuthoritiesDao;
import com.biz.navy.dao.UserDao;
import com.biz.navy.domain.AuthorityVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.UserDetailsVO;
import com.biz.navy.utils.DateTime;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service("userService")
public class UserService implements UserDetailsService{

	private final PasswordEncoder passwordEncoder;
	
	private final UserDao userDao;
	private final AuthoritiesDao authDao;
	
	
	public int insert(String username, String password, String address, String address_etc) {
		String encPassword = passwordEncoder.encode(password);
		UserDetailsVO userVO = UserDetailsVO.builder()
								.username(username)
								.password(encPassword)
								.address(address)
								.address_etc(address_etc)
								.join_date(DateTime.Date())
								.enabled(true)
								.build();
		log.debug("여기는 조인 인서트 서비스 어드레스 " + address);
		int ret = userDao.insert(userVO);
		
		List<AuthorityVO> authList = new ArrayList();
		authList.add(AuthorityVO.builder()
						.username(userVO.getUsername())
						.authority("ROLE_USER").build()
				);
		
		
		authList.add(AuthorityVO.builder()
				.username(userVO.getUsername())
				.authority("USER").build());
		
		// authDao.insert(authList);
	
		return ret;
		
	}


	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		UserDetailsVO userVO = userDao.findByUserName(username);
		if(userVO == null) {
			throw new UsernameNotFoundException("User Name이 없습니다");
		}
		userVO.setEnabled(true);
		
		userVO.setAccountNonExpired(true);
		userVO.setAccountNonLocked(true);
		userVO.setCredentialsNonExpired(true);
		
		userVO.setAuthorities(this.getAuthorities(username));
		
		
		return userVO;
	}
	
	private Collection<GrantedAuthority> getAuthorities(String username) {
		List<AuthorityVO> authList = authDao.findByUserName(username);
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(AuthorityVO vo : authList) {
			SimpleGrantedAuthority sAuth = new SimpleGrantedAuthority(vo.getAuthority());
			authorities.add(sAuth);
		}
		
		return authorities;
	}


	public boolean check_password(String password) {
		// TODO Auto-generated method stub
		UserDetailsVO userVO = (UserDetailsVO) SecurityContextHolder
							.getContext()
							.getAuthentication()
							.getPrincipal();
		return passwordEncoder.matches(password.trim(), userVO.getPassword());
	}

	/**
	 *  유저리스트 조회
	 * @return
	 * @author bjmin17
	 */
	public List<UserDetailsVO> selectAll() {
		return userDao.selectAll();
	}

	public List<UserDetailsVO> selectAllPaging(PageVO pageVO) {
		return userDao.selectAllPaging(pageVO);
	}
	
	/**
	 * 유저 디테일 조회
	 * @param username
	 * @return
	 * @author bjmin17
	 */
	public UserDetailsVO findByUserName(String username) {

		return userDao.findByUserName(username);
	}

	/**
	 * 관리자가 유저 정보 수정(권한 수정)
	 * @param userVO
	 * @param authList
	 * @return
	 * 
	 * @author bjmin17
	 */
	public int update(UserDetailsVO userVO, String[] authList) {
		
//		String[] authList1 = new String[];
		int ret = userDao.update_auth(userVO);
		
		// DB Update를 성공하면
		// 로그인된 session 정보를 update 수행
		if(ret > 0) {
			List<AuthorityVO> authCollection = new ArrayList<>();
			
			for(String auth : authList) {
				// auth가 빈칸인 경우가 생기지 않게 검사
				if(!auth.isEmpty()) {
					AuthorityVO authVO = AuthorityVO.builder()
									.username(userVO.getUsername())
									.authority(auth).build();
					
					authCollection.add(authVO);
				}
			}
			
			authDao.delete(userVO.getUsername());
			authDao.insert(authCollection);
		}
		
		return ret;
	}

	/**
	 * mypage
	 * @param userVO
	 * @param password
	 * @return
	 * @author jjong9950
	 */
	public int update(UserDetailsVO userVO, String password) {
		// TODO Auto-generated method stub
		
		// 권한 객체 oldAuth를 선언하고 SecurityHolder~~에 들어있는 정보를 가져와 주입한다.
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
		
		// password를 매개변수로 받아 암호화 시킨후 선언한 객체에 넣어준다.
		String encPassword = passwordEncoder.encode(password);
		log.debug("암호화된 패스워드인가" + encPassword);
		
		// 권한객체에 principal()을 가져와 VO에 주입
		UserDetailsVO oldUserVO = (UserDetailsVO) oldAuth.getPrincipal();
		
		// vo에 원래 내용담기
		oldUserVO.setEmail(userVO.getEmail());
		oldUserVO.setPhone(userVO.getPhone());
		oldUserVO.setAddress(userVO.getAddress());
		oldUserVO.setAddress_etc(userVO.getAddress_etc());

		// 암호화된 password를 vo에 직접 담아줘야한다.
		userVO.setPassword(encPassword);
		userVO.setPhone(userVO.getPhone());
		userVO.setAddress(userVO.getAddress());
		userVO.setAddress_etc(userVO.getAddress_etc());
		userVO.setEmail(userVO.getEmail());
		log.debug("서비스 유저VO : " + userVO.toString());
		int ret = userDao.update(userVO);
		
		if(ret > 0) {
			Authentication newAuth = new UsernamePasswordAuthenticationToken(oldUserVO, 
							oldAuth.getCredentials(), oldAuth.getAuthorities());
			
			SecurityContextHolder.getContext().setAuthentication(newAuth);
		}
		
		return ret;
	}

	// 권한 삭제
	public int delete(long id) {

		int ret = authDao.delete_id(id);
		return ret;
	}


	public long totalCount(String search) {
		
		long ret = 0;
		if(search == "") {
			ret = userDao.countAll();
		} else {
			List<String> searchList = Arrays.asList(search.split(" "));
			// 검색 결과의 totalCount 구하기
			ret = userDao.countSearch(searchList);
		}
		return ret;
	}


	// 이름으로 검색
	public List<UserDetailsVO> findBySearchName(String search, PageVO pageVO) {

		List<String> searchList = Arrays.asList(search.split(" "));
		
		List<UserDetailsVO> userNameList = new ArrayList<UserDetailsVO>();
		if(search != "") {
			userNameList = userDao.findBySearchNameAndPaging(searchList, pageVO);
			for(UserDetailsVO u : userNameList) {
				log.debug("검색 후 리스트 유저네임 : "+u.getUsername());
			}
		} else {
			userNameList = userDao.selectAllPaging(pageVO);
		}
		
		return userNameList;
	}


	
}
