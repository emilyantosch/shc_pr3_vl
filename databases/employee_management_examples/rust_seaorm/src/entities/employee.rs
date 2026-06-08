use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel)]
#[sea_orm(table_name = "employee")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub ssn: String,
    pub fname: String,
    pub minit: Option<String>,
    pub lname: String,
    pub bdate: Option<Date>,
    pub address: Option<String>,
    pub sex: Option<String>,
    pub salary: i32,
    pub super_ssn: Option<String>,
    pub dno: i32,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
