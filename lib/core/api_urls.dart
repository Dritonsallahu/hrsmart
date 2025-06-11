// ignore_for_file: constant_identifier_names

const host = "http://192.168.1.5:3000/api/v1";
// const host = 'https://business-management-2eaeeb9ab723.herokuapp.com/api/v1';

// Auth
const LOGIN_URL = "$host/login";
const REGISTRATION_URL = "$host/registration";

// Superadmin URLS
const ADD_BUSINESS_URL = "$host/superadmin/business";
const GET_ALL_BUSINESSES_URL = "$host/superadmin/businesses";
const ACCEPT_BUSINESS_URL = "$host/business-admin/accept-business";

// Business URLS
const EMPLOYEE_URL = "$host/business-admin/employee";
const EMPLOYEES_LIST_URL = "$host/business-admin/employees";
const EMPLOYEE_DETAILS_URL = "$host/business-admin/employee-details";

const ADD_EXPENSE_URL = "$host/business-admin/add-expense";
const EXPENSES_URL = "$host/business-admin/expenses";
const EMPLOYEE_EXPENSES_URL = "$host/business-admin/employee-expenses";

const START_CHECKOUT_URL = "$host/business-admin/start-checkout";
const CLOSE_CHECKOUT_URL = "$host/business-admin/close-checkout";
const CHECKOUT_URL = "$host/business-admin/checkout";
const CHECKOUTS_URL = "$host/business-admin/checkouts";
const CLOSE_MONTHLY_CHECKOUT_URL = "$host/business-admin/close-month";

// Employee URLs
const EMP_EXPENSES_URL = "$host/employee/expenses";
const EMP_DETAILS_URL = "$host/employee";



