package org.team10.washcode.service;

import jakarta.servlet.http.Cookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.team10.washcode.RequestDTO.user.LoginReqDTO;
import org.team10.washcode.RequestDTO.user.RegisterReqDTO;
import org.team10.washcode.ResponseDTO.user.UserProfileResDTO;
import org.team10.washcode.entity.User;
import org.team10.washcode.repository.UserRepository;

@Service
public class UserService {

    @Value("${ACCESS_TOKEN_EXPIRATION_TIME}")
    private int ACCESS_TOKEN_EXPIRATION_TIME;

    @Value("${REFRESH_TOKEN_EXPIRATION_TIME}")
    private int REFRESH_TOKEN_EXPIRATION_TIME;


    @Autowired
    private UserRepository userRepository;


    public ResponseEntity<?> signup(RegisterReqDTO registerReqDTO){
        try {
            // 이메일 검증
            if(userRepository.findByEmailExists(registerReqDTO.getEmail())>0){
                return ResponseEntity.status(409).body("이미 사용중인 이메일 입니다.");
            }

            User user = new User();
            user.setEmail(registerReqDTO.getEmail());
            user.setPassword(registerReqDTO.getPassword());
            user.setName(registerReqDTO.getName());
            user.setAddress(registerReqDTO.getAddress());
            user.setPhone(registerReqDTO.getPhone());
            user.setRole(registerReqDTO.getRole());
            user.setKakao_id(registerReqDTO.getKakao_id());

            userRepository.save(user);

            return ResponseEntity.ok().body("회원가입에 성공했습니다.");
        } catch (Exception e) {
            System.out.println("[Error] "+e.getMessage());
            return ResponseEntity.status(500).body("DB 에러");
        }
    }

    public ResponseEntity<?> login(LoginReqDTO loginReqDTO){
        try {
            // 이메일 검증
            if(userRepository.findByEmailExists(loginReqDTO.getEmail())==0){
                return ResponseEntity.status(409).body("계정을 찾을 수 없습니다.");
            }
            // 비밀번호 검증 (추후 암호화 예정)
            if(userRepository.findByPasswordEquals(loginReqDTO.getEmail(),loginReqDTO.getPassword())==0){
                return ResponseEntity.status(400).body("잘못된 비밀번호 입니다.");
            }

            Integer userId = userRepository.findIdByEmail(loginReqDTO.getEmail()).get();

            ResponseCookie access_cookie = ResponseCookie
                    .from("ACCESSTOKEN", userId.toString()) // 추후 토큰값 추가
                    .domain("localhost")
                    .path("/")
                    .httpOnly(true)
                    .maxAge(ACCESS_TOKEN_EXPIRATION_TIME)
                    .build();

            ResponseCookie refresh_cookie = ResponseCookie
                    .from("REFRESHTOKEN", "5678") // 추후 토큰값 추가
                    .domain("localhost")
                    .path("/")
                    .httpOnly(true)
                    .maxAge(REFRESH_TOKEN_EXPIRATION_TIME)
                    .build();

            return ResponseEntity
                    .ok()
                    .header(HttpHeaders.SET_COOKIE, access_cookie.toString(), refresh_cookie.toString())
                    .body("로그인에 성공했습니다.");
        } catch (Exception e) {
            System.out.println("[Error] "+e.getMessage());
            return ResponseEntity.status(500).body("DB 에러");
        }
    }

    public ResponseEntity<?> getUser(Long id){
        UserProfileResDTO userProfileResDTO = new UserProfileResDTO();

        userRepository.findById(id);
        return ResponseEntity.ok().body(userProfileResDTO);
    }

    public ResponseEntity<?> getUserRole(Cookie cookie){
        try {
            return ResponseEntity.ok().body(userRepository.findRoleAndNameById(Integer.parseInt(cookie.getValue())));
        } catch (Exception e) {
            return ResponseEntity.status(400).body("잘못된 토큰 값");
        }
    }

    public ResponseEntity<?> getUserAddress(Cookie cookie){
        try {
            return ResponseEntity.ok().body(userRepository.findAddressById(Integer.parseInt(cookie.getValue())));
        } catch (Exception e) {
            return ResponseEntity.status(400).body("잘못된 토큰 값");
        }
    }
}
