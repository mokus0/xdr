{-# OPTIONS_GHC -fno-warn-overlapping-patterns #-}
module Language.XDR.Parser
    ( module Syn
    , xdr
    , definition
    , declaration
    , type_specifier
    , ParseXDR
    , parseXDR
    ) where

import qualified Language.XDR.Lexer  as Lex
import qualified Language.XDR.Syntax as Syn
import Language.XDR.ParseMonad
import Data.Maybe (isJust)

-- parser produced by Happy Version 1.18.4

data HappyAbsSyn t18 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38
	= HappyTerminal (Lex.Token)
	| HappyErrorToken Int
	| HappyAbsSyn7 (Syn.Declaration)
	| HappyAbsSyn8 (Syn.Multiplicity)
	| HappyAbsSyn9 (Syn.Value)
	| HappyAbsSyn10 (Syn.TypeSpecifier)
	| HappyAbsSyn11 (Syn.Signedness)
	| HappyAbsSyn12 (Syn.EnumBody)
	| HappyAbsSyn13 ((Syn.Identifier, Syn.Value))
	| HappyAbsSyn14 (Syn.StructBody)
	| HappyAbsSyn16 (Syn.UnionBody)
	| HappyAbsSyn17 ((Syn.Value, Syn.Declaration))
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 (Syn.ConstantDef)
	| HappyAbsSyn20 (Syn.TypeDef)
	| HappyAbsSyn21 (Syn.Definition)
	| HappyAbsSyn22 (Syn.Specification)
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34
	| HappyAbsSyn35 t35
	| HappyAbsSyn36 t36
	| HappyAbsSyn37 t37
	| HappyAbsSyn38 t38

action_0 (50) = happyShift action_25
action_0 (51) = happyShift action_26
action_0 (52) = happyShift action_27
action_0 (56) = happyShift action_28
action_0 (57) = happyShift action_29
action_0 (19) = happyGoto action_22
action_0 (20) = happyGoto action_23
action_0 (21) = happyGoto action_30
action_0 (22) = happyGoto action_31
action_0 (23) = happyGoto action_32
action_0 (32) = happyGoto action_33
action_0 (37) = happyGoto action_34
action_0 _ = happyReduce_40

action_1 (50) = happyShift action_25
action_1 (51) = happyShift action_26
action_1 (52) = happyShift action_27
action_1 (56) = happyShift action_28
action_1 (57) = happyShift action_29
action_1 (19) = happyGoto action_22
action_1 (20) = happyGoto action_23
action_1 (21) = happyGoto action_24
action_1 _ = happyFail

action_2 (39) = happyShift action_8
action_2 (41) = happyShift action_19
action_2 (42) = happyShift action_20
action_2 (43) = happyShift action_21
action_2 (44) = happyShift action_9
action_2 (47) = happyShift action_10
action_2 (48) = happyShift action_11
action_2 (49) = happyShift action_12
action_2 (50) = happyShift action_13
action_2 (51) = happyShift action_14
action_2 (52) = happyShift action_15
action_2 (7) = happyGoto action_17
action_2 (10) = happyGoto action_18
action_2 (11) = happyGoto action_6
action_2 (28) = happyGoto action_7
action_2 _ = happyReduce_48

action_3 (39) = happyShift action_8
action_3 (44) = happyShift action_9
action_3 (47) = happyShift action_10
action_3 (48) = happyShift action_11
action_3 (49) = happyShift action_12
action_3 (50) = happyShift action_13
action_3 (51) = happyShift action_14
action_3 (52) = happyShift action_15
action_3 (10) = happyGoto action_16
action_3 (11) = happyGoto action_6
action_3 (28) = happyGoto action_7
action_3 _ = happyReduce_48

action_4 (39) = happyShift action_8
action_4 (44) = happyShift action_9
action_4 (47) = happyShift action_10
action_4 (48) = happyShift action_11
action_4 (49) = happyShift action_12
action_4 (50) = happyShift action_13
action_4 (51) = happyShift action_14
action_4 (52) = happyShift action_15
action_4 (10) = happyGoto action_5
action_4 (11) = happyGoto action_6
action_4 (28) = happyGoto action_7
action_4 _ = happyFail

action_5 (39) = happyShift action_43
action_5 _ = happyFail

action_6 (45) = happyShift action_51
action_6 (46) = happyShift action_52
action_6 _ = happyFail

action_7 _ = happyReduce_23

action_8 _ = happyReduce_22

action_9 _ = happyReduce_47

action_10 _ = happyReduce_16

action_11 _ = happyReduce_17

action_12 _ = happyReduce_18

action_13 (60) = happyShift action_50
action_13 (12) = happyGoto action_49
action_13 _ = happyFail

action_14 (60) = happyShift action_48
action_14 (14) = happyGoto action_47
action_14 _ = happyFail

action_15 (53) = happyShift action_46
action_15 (16) = happyGoto action_45
action_15 _ = happyFail

action_16 (71) = happyAccept
action_16 _ = happyFail

action_17 (71) = happyAccept
action_17 _ = happyFail

action_18 (39) = happyShift action_43
action_18 (66) = happyShift action_44
action_18 _ = happyFail

action_19 (39) = happyShift action_42
action_19 _ = happyFail

action_20 (39) = happyShift action_41
action_20 _ = happyFail

action_21 _ = happyReduce_8

action_22 _ = happyReduce_37

action_23 _ = happyReduce_36

action_24 (71) = happyAccept
action_24 _ = happyFail

action_25 (39) = happyShift action_40
action_25 _ = happyFail

action_26 (39) = happyShift action_39
action_26 _ = happyFail

action_27 (39) = happyShift action_38
action_27 _ = happyFail

action_28 (39) = happyShift action_37
action_28 _ = happyFail

action_29 (39) = happyShift action_8
action_29 (41) = happyShift action_19
action_29 (42) = happyShift action_20
action_29 (43) = happyShift action_21
action_29 (44) = happyShift action_9
action_29 (47) = happyShift action_10
action_29 (48) = happyShift action_11
action_29 (49) = happyShift action_12
action_29 (50) = happyShift action_13
action_29 (51) = happyShift action_14
action_29 (52) = happyShift action_15
action_29 (7) = happyGoto action_36
action_29 (10) = happyGoto action_18
action_29 (11) = happyGoto action_6
action_29 (28) = happyGoto action_7
action_29 _ = happyReduce_48

action_30 _ = happyReduce_61

action_31 (71) = happyAccept
action_31 _ = happyFail

action_32 _ = happyReduce_38

action_33 _ = happyReduce_39

action_34 (50) = happyShift action_25
action_34 (51) = happyShift action_26
action_34 (52) = happyShift action_27
action_34 (56) = happyShift action_28
action_34 (57) = happyShift action_29
action_34 (19) = happyGoto action_22
action_34 (20) = happyGoto action_23
action_34 (21) = happyGoto action_35
action_34 _ = happyReduce_54

action_35 _ = happyReduce_62

action_36 (70) = happyShift action_72
action_36 _ = happyFail

action_37 (67) = happyShift action_71
action_37 _ = happyFail

action_38 (53) = happyShift action_46
action_38 (16) = happyGoto action_70
action_38 _ = happyFail

action_39 (60) = happyShift action_48
action_39 (14) = happyGoto action_69
action_39 _ = happyFail

action_40 (60) = happyShift action_50
action_40 (12) = happyGoto action_68
action_40 _ = happyFail

action_41 (64) = happyShift action_67
action_41 _ = happyFail

action_42 (58) = happyShift action_64
action_42 (64) = happyShift action_65
action_42 (8) = happyGoto action_66
action_42 _ = happyFail

action_43 (58) = happyShift action_64
action_43 (64) = happyShift action_65
action_43 (8) = happyGoto action_62
action_43 (26) = happyGoto action_63
action_43 _ = happyReduce_44

action_44 (39) = happyShift action_61
action_44 _ = happyFail

action_45 _ = happyReduce_21

action_46 (62) = happyShift action_60
action_46 _ = happyFail

action_47 _ = happyReduce_20

action_48 (39) = happyShift action_8
action_48 (41) = happyShift action_19
action_48 (42) = happyShift action_20
action_48 (43) = happyShift action_21
action_48 (44) = happyShift action_9
action_48 (47) = happyShift action_10
action_48 (48) = happyShift action_11
action_48 (49) = happyShift action_12
action_48 (50) = happyShift action_13
action_48 (51) = happyShift action_14
action_48 (52) = happyShift action_15
action_48 (7) = happyGoto action_56
action_48 (10) = happyGoto action_18
action_48 (11) = happyGoto action_6
action_48 (15) = happyGoto action_57
action_48 (24) = happyGoto action_58
action_48 (28) = happyGoto action_7
action_48 (33) = happyGoto action_59
action_48 _ = happyReduce_48

action_49 _ = happyReduce_19

action_50 (39) = happyShift action_55
action_50 (13) = happyGoto action_53
action_50 (30) = happyGoto action_54
action_50 _ = happyFail

action_51 _ = happyReduce_14

action_52 _ = happyReduce_15

action_53 (68) = happyShift action_94
action_53 (31) = happyGoto action_90
action_53 (35) = happyGoto action_91
action_53 (36) = happyGoto action_92
action_53 (38) = happyGoto action_93
action_53 _ = happyReduce_53

action_54 (61) = happyShift action_89
action_54 _ = happyFail

action_55 (67) = happyShift action_88
action_55 _ = happyFail

action_56 (70) = happyShift action_87
action_56 _ = happyFail

action_57 _ = happyReduce_55

action_58 (61) = happyShift action_86
action_58 _ = happyFail

action_59 (39) = happyShift action_8
action_59 (41) = happyShift action_19
action_59 (42) = happyShift action_20
action_59 (43) = happyShift action_21
action_59 (44) = happyShift action_9
action_59 (47) = happyShift action_10
action_59 (48) = happyShift action_11
action_59 (49) = happyShift action_12
action_59 (50) = happyShift action_13
action_59 (51) = happyShift action_14
action_59 (52) = happyShift action_15
action_59 (61) = happyReduce_41
action_59 (7) = happyGoto action_56
action_59 (10) = happyGoto action_18
action_59 (11) = happyGoto action_6
action_59 (15) = happyGoto action_85
action_59 (28) = happyGoto action_7
action_59 _ = happyReduce_48

action_60 (39) = happyShift action_8
action_60 (41) = happyShift action_19
action_60 (42) = happyShift action_20
action_60 (43) = happyShift action_21
action_60 (44) = happyShift action_9
action_60 (47) = happyShift action_10
action_60 (48) = happyShift action_11
action_60 (49) = happyShift action_12
action_60 (50) = happyShift action_13
action_60 (51) = happyShift action_14
action_60 (52) = happyShift action_15
action_60 (7) = happyGoto action_84
action_60 (10) = happyGoto action_18
action_60 (11) = happyGoto action_6
action_60 (28) = happyGoto action_7
action_60 _ = happyReduce_48

action_61 _ = happyReduce_7

action_62 _ = happyReduce_43

action_63 _ = happyReduce_4

action_64 (39) = happyShift action_79
action_64 (40) = happyShift action_80
action_64 (9) = happyGoto action_83
action_64 _ = happyFail

action_65 (39) = happyShift action_79
action_65 (40) = happyShift action_80
action_65 (65) = happyShift action_82
action_65 (9) = happyGoto action_81
action_65 _ = happyFail

action_66 _ = happyReduce_5

action_67 (39) = happyShift action_79
action_67 (40) = happyShift action_80
action_67 (9) = happyGoto action_77
action_67 (29) = happyGoto action_78
action_67 _ = happyReduce_50

action_68 (70) = happyShift action_76
action_68 _ = happyFail

action_69 (70) = happyShift action_75
action_69 _ = happyFail

action_70 (70) = happyShift action_74
action_70 _ = happyFail

action_71 (40) = happyShift action_73
action_71 _ = happyFail

action_72 _ = happyReduce_32

action_73 (70) = happyShift action_102
action_73 _ = happyFail

action_74 _ = happyReduce_35

action_75 _ = happyReduce_34

action_76 _ = happyReduce_33

action_77 _ = happyReduce_49

action_78 (65) = happyShift action_101
action_78 _ = happyFail

action_79 _ = happyReduce_13

action_80 _ = happyReduce_12

action_81 (65) = happyShift action_100
action_81 _ = happyFail

action_82 _ = happyReduce_11

action_83 (59) = happyShift action_99
action_83 _ = happyFail

action_84 (63) = happyShift action_98
action_84 _ = happyFail

action_85 _ = happyReduce_56

action_86 _ = happyReduce_26

action_87 _ = happyReduce_27

action_88 (39) = happyShift action_79
action_88 (40) = happyShift action_80
action_88 (9) = happyGoto action_97
action_88 _ = happyFail

action_89 _ = happyReduce_24

action_90 _ = happyReduce_51

action_91 _ = happyReduce_63

action_92 _ = happyReduce_52

action_93 (68) = happyShift action_94
action_93 (35) = happyGoto action_96
action_93 _ = happyReduce_60

action_94 (39) = happyShift action_55
action_94 (13) = happyGoto action_95
action_94 _ = happyFail

action_95 _ = happyReduce_59

action_96 _ = happyReduce_64

action_97 _ = happyReduce_25

action_98 (60) = happyShift action_103
action_98 _ = happyFail

action_99 _ = happyReduce_9

action_100 _ = happyReduce_10

action_101 _ = happyReduce_6

action_102 _ = happyReduce_31

action_103 (54) = happyShift action_107
action_103 (17) = happyGoto action_104
action_103 (25) = happyGoto action_105
action_103 (34) = happyGoto action_106
action_103 _ = happyFail

action_104 _ = happyReduce_57

action_105 (55) = happyShift action_112
action_105 (18) = happyGoto action_110
action_105 (27) = happyGoto action_111
action_105 _ = happyReduce_46

action_106 (54) = happyShift action_107
action_106 (17) = happyGoto action_109
action_106 _ = happyReduce_42

action_107 (39) = happyShift action_79
action_107 (40) = happyShift action_80
action_107 (9) = happyGoto action_108
action_107 _ = happyFail

action_108 (69) = happyShift action_115
action_108 _ = happyFail

action_109 _ = happyReduce_58

action_110 _ = happyReduce_45

action_111 (61) = happyShift action_114
action_111 _ = happyFail

action_112 (69) = happyShift action_113
action_112 _ = happyFail

action_113 (39) = happyShift action_8
action_113 (41) = happyShift action_19
action_113 (42) = happyShift action_20
action_113 (43) = happyShift action_21
action_113 (44) = happyShift action_9
action_113 (47) = happyShift action_10
action_113 (48) = happyShift action_11
action_113 (49) = happyShift action_12
action_113 (50) = happyShift action_13
action_113 (51) = happyShift action_14
action_113 (52) = happyShift action_15
action_113 (7) = happyGoto action_117
action_113 (10) = happyGoto action_18
action_113 (11) = happyGoto action_6
action_113 (28) = happyGoto action_7
action_113 _ = happyReduce_48

action_114 _ = happyReduce_28

action_115 (39) = happyShift action_8
action_115 (41) = happyShift action_19
action_115 (42) = happyShift action_20
action_115 (43) = happyShift action_21
action_115 (44) = happyShift action_9
action_115 (47) = happyShift action_10
action_115 (48) = happyShift action_11
action_115 (49) = happyShift action_12
action_115 (50) = happyShift action_13
action_115 (51) = happyShift action_14
action_115 (52) = happyShift action_15
action_115 (7) = happyGoto action_116
action_115 (10) = happyGoto action_18
action_115 (11) = happyGoto action_6
action_115 (28) = happyGoto action_7
action_115 _ = happyReduce_48

action_116 (70) = happyShift action_119
action_116 _ = happyFail

action_117 (70) = happyShift action_118
action_117 _ = happyFail

action_118 _ = happyReduce_30

action_119 _ = happyReduce_29

happyReduce_4 = happySpecReduce_3  7 happyReduction_4
happyReduction_4 (HappyAbsSyn26  happy_var_3)
	(HappyTerminal (Lex.Identifier happy_var_2 _))
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 (Syn.BasicDec happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  7 happyReduction_5
happyReduction_5 (HappyAbsSyn8  happy_var_3)
	(HappyTerminal (Lex.Identifier happy_var_2 _))
	_
	 =  HappyAbsSyn7
		 (Syn.OpaqueDec happy_var_2 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happyReduce 5 7 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Lex.Identifier happy_var_2 _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Syn.StringDec happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_3  7 happyReduction_7
happyReduction_7 (HappyTerminal (Lex.Identifier happy_var_3 _))
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 (Syn.OptionalDec happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn7
		 (Syn.VoidDec
	)

happyReduce_9 = happySpecReduce_3  8 happyReduction_9
happyReduction_9 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Syn.Fixed    happy_var_2
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  8 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Syn.Bounded  happy_var_2
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  8 happyReduction_11
happyReduction_11 _
	_
	 =  HappyAbsSyn8
		 (Syn.Unbounded
	)

happyReduce_12 = happySpecReduce_1  9 happyReduction_12
happyReduction_12 (HappyTerminal (Lex.Constant   happy_var_1 _))
	 =  HappyAbsSyn9
		 (Syn.Lit happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  9 happyReduction_13
happyReduction_13 (HappyTerminal (Lex.Identifier happy_var_1 _))
	 =  HappyAbsSyn9
		 (Syn.Var happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  10 happyReduction_14
happyReduction_14 _
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (Syn.Int     happy_var_1
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  10 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (Syn.Hyper   happy_var_1
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  10 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn10
		 (Syn.Float
	)

happyReduce_17 = happySpecReduce_1  10 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn10
		 (Syn.Double
	)

happyReduce_18 = happySpecReduce_1  10 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn10
		 (Syn.Bool
	)

happyReduce_19 = happySpecReduce_2  10 happyReduction_19
happyReduction_19 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Syn.Enum    happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  10 happyReduction_20
happyReduction_20 (HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Syn.Struct  happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  10 happyReduction_21
happyReduction_21 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Syn.Union   happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  10 happyReduction_22
happyReduction_22 (HappyTerminal (Lex.Identifier happy_var_1 _))
	 =  HappyAbsSyn10
		 (Syn.TypeVar happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  11 happyReduction_23
happyReduction_23 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn11
		 (if isJust happy_var_1 then Syn.Unsigned else Syn.Signed
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  12 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  13 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_3)
	_
	(HappyTerminal (Lex.Identifier happy_var_1 _))
	 =  HappyAbsSyn13
		 ((happy_var_1, happy_var_3)
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  14 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  15 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happyReduce 8 16 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_7) `HappyStk`
	(HappyAbsSyn25  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Syn.UnionBody happy_var_3 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 5 17 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 ((happy_var_2, happy_var_4)
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 4 18 happyReduction_30
happyReduction_30 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (undefined
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 5 19 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyTerminal (Lex.Constant   happy_var_4 _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Lex.Identifier happy_var_2 _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (Syn.ConstantDef happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_3  20 happyReduction_32
happyReduction_32 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (Syn.BasicDef  happy_var_2
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 20 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (Lex.Identifier happy_var_2 _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Syn.EnumDef   happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 4 20 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	(HappyTerminal (Lex.Identifier happy_var_2 _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Syn.StructDef happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 4 20 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	(HappyTerminal (Lex.Identifier happy_var_2 _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Syn.UnionDef  happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_1  21 happyReduction_36
happyReduction_36 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (Syn.TypeDef  happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  21 happyReduction_37
happyReduction_37 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 (Syn.ConstDef happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  22 happyReduction_38
happyReduction_38 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  23 happyReduction_39
happyReduction_39 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_0  23 happyReduction_40
happyReduction_40  =  HappyAbsSyn23
		 ([]
	)

happyReduce_41 = happySpecReduce_1  24 happyReduction_41
happyReduction_41 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn24
		 (reverse happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  25 happyReduction_42
happyReduction_42 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn25
		 (reverse happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  26 happyReduction_43
happyReduction_43 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn26
		 (Just happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_0  26 happyReduction_44
happyReduction_44  =  HappyAbsSyn26
		 (Nothing
	)

happyReduce_45 = happySpecReduce_1  27 happyReduction_45
happyReduction_45 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn27
		 (Just happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_0  27 happyReduction_46
happyReduction_46  =  HappyAbsSyn27
		 (Nothing
	)

happyReduce_47 = happySpecReduce_1  28 happyReduction_47
happyReduction_47 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn28
		 (Just happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_0  28 happyReduction_48
happyReduction_48  =  HappyAbsSyn28
		 (Nothing
	)

happyReduce_49 = happySpecReduce_1  29 happyReduction_49
happyReduction_49 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn29
		 (Just happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_0  29 happyReduction_50
happyReduction_50  =  HappyAbsSyn29
		 (Nothing
	)

happyReduce_51 = happySpecReduce_2  30 happyReduction_51
happyReduction_51 (HappyAbsSyn31  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1 : happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  31 happyReduction_52
happyReduction_52 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn31
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_0  31 happyReduction_53
happyReduction_53  =  HappyAbsSyn31
		 ([]
	)

happyReduce_54 = happySpecReduce_1  32 happyReduction_54
happyReduction_54 (HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn32
		 (reverse happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  33 happyReduction_55
happyReduction_55 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn33
		 ([happy_var_1]
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_2  33 happyReduction_56
happyReduction_56 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_2 : happy_var_1
	)
happyReduction_56 _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  34 happyReduction_57
happyReduction_57 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn34
		 ([happy_var_1]
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_2  34 happyReduction_58
happyReduction_58 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn34
		 (happy_var_2 : happy_var_1
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  35 happyReduction_59
happyReduction_59 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn35
		 (happy_var_2
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  36 happyReduction_60
happyReduction_60 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn36
		 (reverse happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  37 happyReduction_61
happyReduction_61 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn37
		 ([happy_var_1]
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_2  37 happyReduction_62
happyReduction_62 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn37
		 (happy_var_2 : happy_var_1
	)
happyReduction_62 _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  38 happyReduction_63
happyReduction_63 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn38
		 ([happy_var_1]
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_2  38 happyReduction_64
happyReduction_64 (HappyAbsSyn35  happy_var_2)
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (happy_var_2 : happy_var_1
	)
happyReduction_64 _ _  = notHappyAtAll 

happyNewToken action sts stk
	= getToken(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	Lex.EOF -> action 71 71 tk (HappyState action) sts stk;
	Lex.Identifier happy_dollar_dollar _ -> cont 39;
	Lex.Constant   happy_dollar_dollar _ -> cont 40;
	Lex.Opaque        _ -> cont 41;
	Lex.String        _ -> cont 42;
	Lex.Void          _ -> cont 43;
	Lex.Unsigned      _ -> cont 44;
	Lex.Int           _ -> cont 45;
	Lex.Hyper         _ -> cont 46;
	Lex.Float         _ -> cont 47;
	Lex.Double        _ -> cont 48;
	Lex.Bool          _ -> cont 49;
	Lex.Enum          _ -> cont 50;
	Lex.Struct        _ -> cont 51;
	Lex.Union         _ -> cont 52;
	Lex.Switch        _ -> cont 53;
	Lex.Case          _ -> cont 54;
	Lex.Default       _ -> cont 55;
	Lex.Const         _ -> cont 56;
	Lex.TypeDef       _ -> cont 57;
	Lex.LSquare       _ -> cont 58;
	Lex.RSquare       _ -> cont 59;
	Lex.LBrace        _ -> cont 60;
	Lex.RBrace        _ -> cont 61;
	Lex.LParen        _ -> cont 62;
	Lex.RParen        _ -> cont 63;
	Lex.LAngle        _ -> cont 64;
	Lex.RAngle        _ -> cont 65;
	Lex.Star          _ -> cont 66;
	Lex.Equals        _ -> cont 67;
	Lex.Comma         _ -> cont 68;
	Lex.Colon         _ -> cont 69;
	Lex.SemiColon     _ -> cont 70;
	_ -> happyError' tk
	})

happyError_ tk = happyError' tk

happyThen :: () => ParseXDR a -> (a -> ParseXDR b) -> ParseXDR b
happyThen = (>>=)
happyReturn :: () => a -> ParseXDR a
happyReturn = (return)
happyThen1 = happyThen
happyReturn1 :: () => a -> ParseXDR a
happyReturn1 = happyReturn
happyError' :: () => (Lex.Token) -> ParseXDR a
happyError' tk = (\token -> happyError) tk

xdr = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn22 z -> happyReturn z; _other -> notHappyAtAll })

definition = happySomeParser where
  happySomeParser = happyThen (happyParse action_1) (\x -> case x of {HappyAbsSyn21 z -> happyReturn z; _other -> notHappyAtAll })

declaration = happySomeParser where
  happySomeParser = happyThen (happyParse action_2) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

type_specifier = happySomeParser where
  happySomeParser = happyThen (happyParse action_3) (\x -> case x of {HappyAbsSyn10 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


happyError = fail msg
    where
        msg = "parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 28 "templates/GenericTemplate.hs" #-}








{-# LINE 49 "templates/GenericTemplate.hs" #-}

{-# LINE 59 "templates/GenericTemplate.hs" #-}

{-# LINE 68 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 253 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 317 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
