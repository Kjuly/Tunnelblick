%define		name		pkcs11-helper
%define		version		1.09
%define		release		2
%define		prefix		/usr
%define		with_doc	0

Summary:	pkcs11-helper is a helper library for the use with smart cards and the PKCS#11 API
Name:		%{name}
Version:	%{version}
Release:	%{release}%{dist}
License:	GPL-2/BSD
Vendor:		The OpenSC Project, http://www.opensc-project.org
Packager:	Eddy Nigg <eddy_nigg@startcom.org>
Group:		System/Crypto
Url:		http://www.opensc-project.org/pkcs11-helper
Source:		http://www.opensc-project.org/files/pkcs11-helper/%{name}-%{version}.tar.bz2
BuildRoot:	/var/tmp/%{name}-%{version}-%{release}
%if %{?with_doc}
BuildRequires:	doxygen
%endif
BuildRequires:	openssl-devel >= 0.9.7a
Requires:	openssl >= 0.9.7a
Provides:	%{name} = %{version}

%description
pkcs11-helper allows using multiple PKCS#11 providers at the same 
time, selecting keys by id, label or certificate subject, handling 
card removal and card insert events, handling card re-insert to a 
different slot, supporting session expiration serialization and much 
more, all using a simple API.

%package devel
Summary:	pkcs11-helper development files
Group:		Development/Libraries
Requires:	%{name} >= %{version}
Requires:	pkgconfig

%description devel
pkcs11-helper development files.

%prep
%setup -q

%build
%configure -q \
	--disable-rpath \
%if %{?with_doc}
	--enable-doc
%endif

make %{?_smp_mflags}

%install
if [ -d $RPM_BUILD_ROOT ]; then rm -rf $RPM_BUILD_ROOT; fi

%makeinstall 

%clean
if [ -d $RPM_BUILD_ROOT ]; then rm -rf $RPM_BUILD_ROOT; fi

%files
%defattr(-,root,root)
%{_libdir}/libpkcs11-helper.*
%{_mandir}/*
%{_docdir}/%{name}/COPYING*
%{_docdir}/%{name}/README

%files devel
%defattr(-,root,root,-)
%{_includedir}/*
%{_libdir}/pkgconfig/*
%{_datadir}/aclocal/*
%if %{?with_doc}
%{_docdir}/%{name}/api/*
%endif

%changelog
* Mon Feb 15 2007 Aon Bar-Lev <alon.barlev@gmail.com>
- Modify docs location.

* Mon Jan 15 2007 Eddy Nigg <eddy_nigg@startcom.org>
- Make doxygen dependency only for doc builds 

* Tue Jan 9 2007 Eddy Nigg <eddy_nigg@startcom.org>
- Build new version 1.03

* Sun Jan 7 2007 Eddy Nigg <eddy_nigg@startcom.org>
- Fix for pkgconfig.

* Mon Nov 27 2006 Eddy Nigg <eddy_nigg@startcom.org>
- Fix documentation.

* Sun Nov 26 2006 Eddy Nigg <eddy_nigg@startcom.org>
- Initial build for StartCom Linux 5.0.x
