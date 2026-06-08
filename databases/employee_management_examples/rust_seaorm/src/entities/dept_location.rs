use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel)]
#[sea_orm(table_name = "dept_locations")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub dnumber: i32,
    #[sea_orm(primary_key, auto_increment = false)]
    pub dlocation: String,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
