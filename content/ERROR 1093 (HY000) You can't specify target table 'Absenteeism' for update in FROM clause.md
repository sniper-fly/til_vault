---
tags:
  - mysql
---

`ERROR 1093 (HY000): You can't specify target table 'Absenteeism' for update in FROM clause`

以下のクエリ
```sql
update
  Absenteeism as a1
set
  severity_points = 0,
  reason_code = 'long term illness'
where
  exists (
    select
      *
    from
      Absenteeism as a2
    where
      a1.emp_id = a2.emp_id
      and a1.absent_date = (a2.absent_date + interval 1 day)
  );
```

exists句の中のfromを書き換えることで回避
```sql
update
  Absenteeism as a1
set
  severity_points = 0,
  reason_code = 'long term illness'
where
  exists (
    select
      *
    from
      (
        select
          *
        from
          Absenteeism
      ) as a2
    where
      a1.emp_id = a2.emp_id
      and a1.absent_date = (a2.absent_date + interval 1 day)
  );
```

[MySQLで You can't specify target table 'xxxx' for update in F...](https://qiita.com/kohekohe1221/items/d1cbdc1d3affcd9c3a9e)