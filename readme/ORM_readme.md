# 📘 Vania ORM 프로젝트 컨벤션 가이드

본 문서는 Vania 기반 프로젝트에서 사용하는 디렉토리 구조 및 로직 처리 규칙을 정리한 것입니다.  
Spring Boot 스타일의 구조와 유사하게, 계층별 책임을 명확히 나누는 것을 목표로 합니다.

---

## ✅ **Convention List**

### 1. 응답 및 반환 처리
- ✅ **성공/실패 응답**은 **Controller**가 담당합니다.
- ✅ **데이터 존재 유무 및 반환 값**은 **Service**에서 처리합니다.

> `The return of response success or failure is returned by the Controller,`  
> `and whether or not data is returned is returned by the Services unit.`

---

### 2. 폴더 구조 규칙
- 📂 **Controller** → `/lib/app/controllers`
- 📂 **Model (Domain Entity)** → `/lib/app/models`
- 📂 **기타 로우레벨 처리 (ex. Migration, Raw SQL)** → `/lib/database`

---

### 3. SQL Query 관련 규칙
- 📂 SQL 관련 **DTO 및 Service**는  
  `/lib/database/query/{table_name}/` 하위에 둡니다.
- 📁 폴더는 **테이블 이름별로 분류**, 내부는 `dto/`, `services/`로 역할 분리

예:
```
lib/
└─ database/
   └─ query/
      └─ users/
         ├─ dto/
         │   └─ user_insert_dto.dart
         └─ services/
             └─ insert_users_table.dart
```

---

### 4. 열거형(enum) 처리
- 📂 열거형은 `/lib/app/models/types/` 하위에 위치
- 📁 종류별로 파일을 분리하고, 명확한 역할을 가짐

---

### 5. 명명 규칙
- ✅ **모든 폴더명, 파일명, 테이블명은 소문자 및 snake_case**로 작성,
> `All file names (table names) and folder names must be in lowercase and snake_case.`

---

## 🧩 Vania ORM 처리 흐름 요약

| 단계 | 책임 | 디렉토리 |
|------|------|----------|
| 1️⃣ | Controller | `/lib/app/controllers` |
| 2️⃣ | Model (Domain) | `/lib/app/models` |
| 3️⃣ | DTO | `/lib/database/query/{table}/dto/` |
| 4️⃣ | Service | `/lib/database/query/{table}/services/` |

---

## 🔗 참고 자료
- [Vania Eloquent ORM 공식 문서](https://vdart.dev/docs/eloquent-orm/eloquent/)
