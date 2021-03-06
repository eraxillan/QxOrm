#ifndef _QX_SERVICE_EXPORT_H_
#define _QX_SERVICE_EXPORT_H_

#ifdef _BUILDING_QX_SERVICE
#define QX_SERVICE_DLL_EXPORT QX_DLL_EXPORT_HELPER
#else // _BUILDING_QX_SERVICE
#define QX_SERVICE_DLL_EXPORT QX_DLL_IMPORT_HELPER
#endif // _BUILDING_QX_SERVICE

#ifdef _BUILDING_QX_SERVICE
#define QX_REGISTER_HPP_QX_SERVICE QX_REGISTER_HPP_EXPORT_DLL
#define QX_REGISTER_CPP_QX_SERVICE QX_REGISTER_CPP_EXPORT_DLL
#else // _BUILDING_QX_SERVICE
#define QX_REGISTER_HPP_QX_SERVICE QX_REGISTER_HPP_IMPORT_DLL
#define QX_REGISTER_CPP_QX_SERVICE QX_REGISTER_CPP_IMPORT_DLL
#endif // _BUILDING_QX_SERVICE

#endif // _QX_SERVICE_EXPORT_H_
