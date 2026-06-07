using Security.Domain.Model;

namespace Security.Domain.Interfaces;

/// <summary>
/// ******************************************************************************
/// NAME:       IEXTR_USRA_PKG
/// PURPOSE:    This interface is the C# representation of the Oracle package EXTR_USRA_PKG
///             which is created in the Oracle database for managing USER_APPLICATION table.
///             
///             این اینترفیس، معادل سی‌شارپ پکیج اکسیرال EXTR_USRA_PKG در اوراکل است
///             که برای مدیریت جدول USER_APPLICATION ساخته شده است.
/// 
/// REVISIONS:
/// Ver        Date        Author           Description
/// ---------  ----------  ---------------  ------------------------------------
/// 1.0        2025-01-20  Hadaeghi         1. Created this interface for USER_APPLICATION
///                                         2. Exact mapping to Oracle package EXTR_USRA_PKG
///                                         3. Bilingual comments (EN/FA)
/// ******************************************************************************
/// </summary>
public interface IEXTR_USRA_SRVC
{
    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: INIT_USRA_U
    /// PURPOSE (EN):  Initialize and validate user information
    /// PURPOSE (FA):  مقداردهی اولیه و اعتبارسنجی اطلاعات کاربر
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): InitializeUserAsync
    /// PARAMETERS:    p_in (JSON string) - user initialization data
    /// RETURNS:       JSON string containing operation status and basic user info
    /// ******************************************************************************
    /// </summary>
    Task<string> INIT_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: LGIN_USRA_U
    /// PURPOSE (EN):  Authenticate user and login to system
    /// PURPOSE (FA):  فرآیند احراز هویت و ورود کاربر به سیستم
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): LoginUserAsync
    /// PARAMETERS:    p_in (JSON string) - username/email and password
    /// RETURNS:       JSON string containing access token, login status, user info
    /// ******************************************************************************
    /// </summary>
    Task<string> LGIN_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: LGOT_USRA_U
    /// PURPOSE (EN):  Logout user and invalidate current session/token
    /// PURPOSE (FA):  خروج کاربر از سیستم و invalidate کردن نشست فعلی
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): LogoutUserAsync
    /// PARAMETERS:    p_in (JSON string) - user token or session identifier
    /// RETURNS:       JSON string containing logout status
    /// ******************************************************************************
    /// </summary>
    Task<string> LGOT_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: CRET_USRA_U
    /// PURPOSE (EN):  Create new user with full validation
    /// PURPOSE (FA):  ایجاد کاربر جدید در سیستم با اعتبارسنجی کامل اطلاعات
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): CreateUserAsync
    /// PARAMETERS:    p_in (JSON string) - complete new user information
    /// RETURNS:       JSON string containing created user code and operation status
    /// ******************************************************************************
    /// </summary>
    Task<string> CRET_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: REMV_USRA_U
    /// PURPOSE (EN):  Soft or hard delete user from system
    /// PURPOSE (FA):  حذف منطقی یا فیزیکی کاربر از سیستم
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): RemoveUserAsync
    /// PARAMETERS:    p_in (JSON string) - user code and delete type (soft/hard)
    /// RETURNS:       JSON string containing deletion status
    /// ******************************************************************************
    /// </summary>
    Task<string> REMV_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: UPDT_USRA_U
    /// PURPOSE (EN):  Update general user information (excluding password/pin)
    /// PURPOSE (FA):  به‌روزرسانی اطلاعات عمومی کاربر (غیر از رمز عبور و pin)
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): UpdateUserAsync
    /// PARAMETERS:    p_in (JSON string) - user code and updatable fields
    /// RETURNS:       JSON string containing update status
    /// ******************************************************************************
    /// </summary>
    Task<string> UPDT_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: ACTV_USRA_U
    /// PURPOSE (EN):  Activate a previously deactivated user account
    /// PURPOSE (FA):  فعال کردن حساب کاربری که قبلاً غیرفعال شده است
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): ActivateUserAsync
    /// PARAMETERS:    p_in (JSON string) - user code and activation level
    /// RETURNS:       JSON string containing activation status
    /// ******************************************************************************
    /// </summary>
    Task<string> ACTV_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: DACT_USRA_U
    /// PURPOSE (EN):  Temporarily deactivate user account
    /// PURPOSE (FA):  غیرفعال کردن موقت حساب کاربری
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): DeactivateUserAsync
    /// PARAMETERS:    p_in (JSON string) - user code and deactivation reason
    /// RETURNS:       JSON string containing deactivation status
    /// ******************************************************************************
    /// </summary>
    Task<string> DACT_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: UPDT_PSWD_U
    /// PURPOSE (EN):  Change user password with old password validation
    /// PURPOSE (FA):  تغییر رمز عبور کاربر با اعتبارسنجی رمز قدیم
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): UpdatePasswordAsync
    /// PARAMETERS:    p_in (JSON string) - user code, old password, new password
    /// RETURNS:       JSON string containing password change status
    /// ******************************************************************************
    /// </summary>
    Task<string> UPDT_PSWD_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: UPDT_PINC_U
    /// PURPOSE (EN):  Change user PIN code for second-factor authentication
    /// PURPOSE (FA):  تغییر PIN کد کاربری برای احراز هویت سطح دوم
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): UpdatePinCodeAsync
    /// PARAMETERS:    p_in (JSON string) - user code and new PIN
    /// RETURNS:       JSON string containing PIN change status
    /// ******************************************************************************
    /// </summary>
    Task<string> UPDT_PINC_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: DUPL_USRA_U
    /// PURPOSE (EN):  Check for duplicate user information (username, email, phone)
    /// PURPOSE (FA):  بررسی تکراری نبودن اطلاعات کاربر (نام کاربری، ایمیل، تلفن)
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): CheckDuplicateUserAsync
    /// PARAMETERS:    p_in (JSON string) - fields to check for duplication
    /// RETURNS:       JSON string containing duplicate check status
    /// ******************************************************************************
    /// </summary>
    Task<string> DUPL_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: CHCK_PRIV_U
    /// PURPOSE (EN):  Check user permissions and access rights for specific operations
    /// PURPOSE (FA):  بررسی سطح دسترسی و مجوزهای کاربر برای انجام عملیات خاص
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): CheckPrivilegeAsync
    /// PARAMETERS:    p_in (JSON string) - user code and operation identifier
    /// RETURNS:       JSON string containing permissions list and access status
    /// ******************************************************************************
    /// </summary>
    Task<string> CHCK_PRIV_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: ENBL_TOTP_U
    /// PURPOSE (EN):  Enable TOTP-based two-factor authentication (Google Authenticator)
    /// PURPOSE (FA):  فعال کردن احراز هویت دو مرحله‌ای مبتنی بر TOTP
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): EnableTotpAsync
    /// PARAMETERS:    p_in (JSON string) - user code and TOTP key for verification
    /// RETURNS:       JSON string containing recovery key and TOTP activation status
    /// ******************************************************************************
    /// </summary>
    Task<string> ENBL_TOTP_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: DSBL_TOTP_U
    /// PURPOSE (EN):  Disable TOTP-based two-factor authentication for user
    /// PURPOSE (FA):  غیرفعال کردن احراز هویت دو مرحله‌ای TOTP برای کاربر
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): DisableTotpAsync
    /// PARAMETERS:    p_in (JSON string) - user code and TOTP code for verification
    /// RETURNS:       JSON string containing TOTP disable status
    /// ******************************************************************************
    /// </summary>
    Task<string> DSBL_TOTP_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: READ_TOTP_U
    /// PURPOSE (EN):  Read TOTP secret and status for a user (login flow only)
    /// PURPOSE (FA):  خواندن کلید مخفی و وضعیت TOTP کاربر (فقط در فلو ورود)
    /// ALTERNATIVE NAME: GetTotpSecretForLoginAsync
    /// PARAMETERS:    p_in (JSON string) - {filter:{USER_APP_NAME:...}}
    /// RETURNS:       JSON string containing TOTP_SCRT_KEY and TOTP_STAT
    /// ******************************************************************************
    /// </summary>
    Task<string> READ_TOTP_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: GETP_USRA_U
    /// PURPOSE (EN):  Show profile and connection for user
    /// PURPOSE (FA):  نمایش اطلاعات کاربر و نحوه اتصال به پایگاه داده
    /// ALTERNATIVE NAME (if you prefer cleaner C# naming): GetUserProfileAsync
    /// PARAMETERS:    p_in (JSON string) - User name for verifing
    /// RETURNS:       JSON string containing USER and Connection
    /// ******************************************************************************
    /// </summary>
    Task<string> GETP_USRA_U(string p_in);

    /// <summary>
    /// ******************************************************************************
    /// FUNCTION NAME: LIST_USRA_U
    /// PURPOSE (FA):  دریافت لیست تمام کاربران سیستم به صورت JSON
    /// PARAMETERS:    p_in (JSON string) - پارامترهای فیلتر (فعلاً خالی)
    /// RETURNS:       JSON string containing array of users
    /// ******************************************************************************
    /// </summary>
    Task<string> LIST_USRA_U(string p_in);
}
